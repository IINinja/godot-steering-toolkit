extends GSTProximity
class_name GSTInfiniteProximity
# Determines any agent that is in the specified list as being neighbors with the
# owner agent.


func _init(agent: GSTSteeringAgent, agents: Array).(agent, agents) -> void:
	pass


# Returns a number of neighbors based on a `callback` function.
#
# `find_neighbors` calls `callback` for each agent in the `agents` array and
# adds one to the count it if `callback` returns true.
func find_neighbors(callback: FuncRef) -> int:
	var neighbor_count := 0
	var agent_count := agents.size()
	for i in range(agent_count):
		var current_agent := agents[i] as GSTSteeringAgent

		if current_agent != agent:
			if callback.call_func(current_agent):
				neighbor_count += 1

	return neighbor_count
