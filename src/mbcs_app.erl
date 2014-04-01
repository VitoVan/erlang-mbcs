%% @doc Supervisor for the mb application.

-module(mbcs_app).
-author('luxiangyu@msn.com').

-behaviour(application).
-behaviour(supervisor).

%% External exports
-export([start/2, init/1, stop/1]).


%% @spec start() -> ServerRet
%% @doc API for starting the supervisor.
start(_, _) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop(_StartArgs) ->
    ok.

%% @spec init(_) -> SupervisorTree
%% @doc supervisor callback, ensures yaws is in embedded mode and then
%%      returns the supervisor tree.
init([]) -> % Supervisor
    Processes = [{mbcs_server, {mbcs_server, start, []},
                 permanent, brutal_kill, worker, [mbcs_server]}],
    {ok, {{one_for_one, 1, 60}, Processes}}.

