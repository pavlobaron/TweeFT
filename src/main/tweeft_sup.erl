%% @copyright 2011 Pavlo Baron

-module(tweeft_sup).
-behaviour(supervisor).

-export([start_link/0, init/1]).

-export([start_session/2, end_session/1]).

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

init(_Args) ->
    {ok, {{one_for_one, 2, 10}, []}}.

start_session(App, Mode) ->
    SessionId = new_session_id(),
    start_server(Mode, SessionId),
    Workers = env_lib:get_env(App, Mode, workers),
    start_workers(Workers, SessionId),
    SessionId.

new_session_id() ->
    Hash = erlang:phash2(make_ref()),
    integer_to_list(Hash).

new_server_id(Mode, SessionId) ->
    list_to_atom(string:concat(atom_to_list(Mode),
			       string:concat("_",
					     SessionId))).
start_server(Mode, SessionId) ->
    ChildId = new_server_id(Mode, SessionId),
    supervisor_lib:start_dynamic_child(?MODULE,
				       tweeft_srv,
				       start_link,
				       [ChildId],
				       transient,
				       2000,
				       worker, 
				       ChildId).

new_worker_id(User, SessionId) ->
    list_to_atom(string:concat(string:concat(
				 string:concat("worker_",
					       User),
				 "_"),
			       SessionId)).

start_workers([], _) ->
    ok;
start_workers([{User, Password}|T], SessionId) ->
    ChildId = new_worker_id(User, SessionId),
    supervisor_lib:start_dynamic_child(?MODULE,
				       tweeft_wrk,
				       start_link,
				       [ChildId],
				       transient,
				       2000,
				       worker, 
				       ChildId),
    start_workers(T, SessionId).

end_session(SessionId) ->
    Filter = fun(Id, Suffix) ->
	       string:rstr(atom_to_list(Id), Suffix) > 0
	     end,

    Kill = fun(Id, ChildId) ->
	     supervisor_lib:kill_dynamic_child(Id, ChildId)
	   end,

    supervisor_lib:apply_to_children(?MODULE,
				     Filter,
				     SessionId,
				     Kill).
