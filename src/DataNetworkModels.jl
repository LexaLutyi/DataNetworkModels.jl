module DataNetworkModels

using LinearAlgebra
using Graphs, GraphNeuralNetworks

include("speed_based.jl")
export propagate_speeds!, channels_load, regulate_speed!, update_speed!

include("flow_channel_mappings.jl")
export map_channels_to_flow_steps

include("routing.jl")
export update_hop_matrix!

end
