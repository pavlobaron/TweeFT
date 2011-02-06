-module(tweeft).
-behaviour(application).

-export([start/2, stop/1]).

-export([run/2]).

start(_Type, _Args) ->
    tweeft_sup:start_link().

stop(_State) -> ok.

run(Mode, Friend) ->
    SessionId = tweeft_sup:start_session(?MODULE, Mode),
    tweeft_sup:end_session(SessionId).
