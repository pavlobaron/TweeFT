%% @copyright 2011 Pavlo Baron

-module(tweeft_wrk).
-behaviour(gen_server).

-export([start_link/1]).
-export([init/1]).
-export([code_change/3]).
-export([handle_call/3]).
-export([handle_cast/2]).
-export([handle_info/2]).
-export([terminate/2]).

-include("tweeft.hrl").

start_link(Id) ->
    gen_server:start_link({local, Id}, ?MODULE, Id, []).

init(Id) ->
    error_logger:info_report("worker started with Args = "),
    error_logger:info_report(Id),
    process_flag(trap_exit, true),
    {ok, #worker_state{id = Id}}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

handle_call(send_file, _From, State) ->
    Result = ok,
    {reply, Result, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Shutdown, _State) ->
    ok.
