module DataNetworkModels

using LinearAlgebra
using Graphs, GraphNeuralNetworks

include("speed_based.jl")
export propagate_speeds!, channels_load, regulate_speed!, update_speed!

include("flow_channel_mappings.jl")
export map_channels_to_flow_steps

include("routing.jl")
export update_hop_matrix!, 
    final_hop_matrix, 
    map_shortest_paths_to_neighbors, 
    find_next_step, 
    find_flow_path,
    node_path_to_channels_path

end
