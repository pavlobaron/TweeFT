%% @author Pavlo Baron <pb@pbit.org>
%% @copyright 2010 Pavlo Baron

-module(env_lib).

-export([get_env/3]).

get_env(App, Area) ->
    Ret = application:get_env(App, Area),
    case Ret of
	{ok, L} -> L;
	_ -> []
    end.

get_env(App, Area, Key) ->
    [H | _T] = [X || {T, X} <- get_env(App, Area), T == Key], H.
