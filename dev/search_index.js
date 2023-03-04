var documenterSearchIndex = {"docs":
[{"location":"#DataNetworkModels.jl","page":"DataNetworkModels.jl","title":"DataNetworkModels.jl","text":"","category":"section"},{"location":"","page":"DataNetworkModels.jl","title":"DataNetworkModels.jl","text":"Documentation for DataNetworkModels.jl","category":"page"},{"location":"","page":"DataNetworkModels.jl","title":"DataNetworkModels.jl","text":"Modules = [DataNetworkModels]\nOrder   = [:function, :type]","category":"page"},{"location":"#DataNetworkModels.channels_load-Tuple{Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.channels_load","text":"channels_load(speeds_flow_step, channels_to_flow_steps)\n\nreturn load for each channel   channels_to_flow_steps maps channel to flows and index of channel in flow   load equals sum of all speeds\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.final_hop_matrix","page":"DataNetworkModels.jl","title":"DataNetworkModels.final_hop_matrix","text":"final_hop_matrix(g, [hop_matrix])\n\nreturn final hop-distance matrix for graph g\n\n\n\n\n\n","category":"function"},{"location":"#DataNetworkModels.find_flow_path-Tuple{Any, Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.find_flow_path","text":"find_flow_path(source, target, shortest_paths_to_neighbors)\n\nreturn vector of nodes including source and target nodes   guaranteed to have minimum length\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.find_next_step-Tuple{Any, Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.find_next_step","text":"find_next_step(source, target, shortest_paths_to_neighbors)\n\nreturn random neighbor lying on the shortest path\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.map_channels_to_flow_steps-Tuple{Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.map_channels_to_flow_steps","text":"map_channels_to_flow_steps(flow_steps_to_channel, channel_number)\n\nreturn vector of tuples:   flow indices and step indices for each channel\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.map_shortest_paths_to_neighbors-Tuple{Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.map_shortest_paths_to_neighbors","text":"map_shortest_paths_to_neighbors(g, hop_matrix)\n\nreturn vector{vector{vector{Int}}} - [source][target][neighbor]   map each pair of (source, target) to subset of source neighbors   who are part of one of the shortest path from source to target\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.propagate_speeds!-Tuple{Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.propagate_speeds!","text":"propagate_speeds!(speeds_flow_step, speeds_start)\n\nupdate speeds for every flow and channel   u[flow][start] := speeds_start[flow]   u[flow][channel] := u[flow][channel - 1]  \n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.regulate_speed!-NTuple{4, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.regulate_speed!","text":"regulate_speed!(speeds_flow_step, current_channels_load, flow_steps_to_channel, max_channels_load)\n\nregulate speed for each flow and channel so channelloads ≤ maxchannels_load\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.update_hop_matrix!-Tuple{Any, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.update_hop_matrix!","text":"update_hop_matrix!(hop_matrix, g)\n\ndistributed (local) update of hop matrix  \n\nafter L updates since last graph change   hop matrix is guaranteed to provide true hop distances   where L - maximum length of shortest paths\n\n\n\n\n\n","category":"method"},{"location":"#DataNetworkModels.update_speed!-NTuple{5, Any}","page":"DataNetworkModels.jl","title":"DataNetworkModels.update_speed!","text":"update_speed!(\n    speeds_flow_step,\n    speeds_start,\n    channels_to_flow_steps,\n    flow_steps_to_channel,\n    max_channels_load\n\n)\n\nupdate all speed for every flow and step   guaranteed that channel load ≤ max channel load\n\n\n\n\n\n","category":"method"}]
}
