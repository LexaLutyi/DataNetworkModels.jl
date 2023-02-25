using DataNetworkModels
using Test
using Graphs, GraphNeuralNetworks
using LinearAlgebra

@testset "propagate_speeds!" begin
    
    speeds_flow_step = [
        [1, 2, 3],
        [1, 2],
        [1]
    ]
    speeds_start = [
        0
        7
        6
    ]
    updated_speeds_flow_step = [
        [0, 0, 2],
        [7, 7],
        [6]
    ]

    result = propagate_speeds!(speeds_flow_step, speeds_start)
    @test speeds_flow_step == updated_speeds_flow_step
    @test result === speeds_flow_step
end


@testset "channels_load" begin
    """
    1 - virtual channel
    2, ... --- real channels
    """
    speeds_flow_step = [
        [1, 2, 3], # 1 -> 2 -> 3
        [1, 2], # 1 -> 3
        [1] # 1
    ]
    channels_to_flow_steps = [
        ([1, 2, 3], [1, 1, 1])
        ([1], [2])
        ([1, 2], [3, 2])
    ]
    channel_loads = [
        3
        2
        5
    ]


    result = channels_load(speeds_flow_step, channels_to_flow_steps)
    @test result == channel_loads
end


@testset "regulate_speed!" begin
    speeds_flow_step = [
        [1., 2., 3.], # 1 -> 2 -> 3
        [1., 2.], # 1 -> 3
        [1.] # 1
    ]
    current_channels_load = [
        3.
        2.
        5.
    ]
    flow_steps_to_channel = [
        [1, 2, 3],
        [1, 3],
        [1]
    ]
    max_channels_load = [
        Inf # 1st channel is virtual
        3.
        1.
    ]
    updated_speeds_flow_step = [
        [1., 2., 0.6], # 1 -> 2 -> 3
        [1., 0.4], # 1 -> 3
        [1.] # 1
    ]


    result = regulate_speed!(speeds_flow_step, current_channels_load, flow_steps_to_channel, max_channels_load)
    @test result === speeds_flow_step
    @test result ≈ updated_speeds_flow_step
end


@testset "update_speed!" begin
    speeds_flow_step = [
        [1., 3., 3.],
        [1., 2.],
        [1.]
    ]
    speeds_start = [
        0
        7
        6
    ]
    channels_to_flow_steps = [
        ([1, 2, 3], [1, 1, 1])
        ([1], [2])
        ([1, 2], [3, 2])
    ]
    flow_steps_to_channel = [
        [1, 2, 3],
        [1, 3],
        [1]
    ]
    max_channels_load = [
        Inf
        3.
        1.
    ]
    updated_speeds_flow_step = [
        [0., 0., 0.3], # 1 -> 2 -> 3
        [7., 0.7], # 1 -> 3
        [6.] # 1
    ]


    result = update_speed!(
        speeds_flow_step,
        speeds_start,
        channels_to_flow_steps,
        flow_steps_to_channel,
        max_channels_load
    )
    @test result === speeds_flow_step
    @test result ≈ updated_speeds_flow_step
end


@testset "map_channels_to_flow_steps" begin
    channels_to_flow_steps = [
        ([1, 2, 3], [1, 1, 1])
        ([1], [2])
        ([1, 2], [3, 2])
    ]
    flow_steps_to_channel = [
        [1, 2, 3],
        [1, 3],
        [1]
    ]
    channel_number = 3

    result = map_channels_to_flow_steps(flow_steps_to_channel, channel_number)
    @test result == channels_to_flow_steps
end


@testset "update_hop_matrix!" begin
    graph_adjacency_matrix = [
        0 1 0 0
        1 0 1 0
        0 1 0 1
        0 0 1 0
    ]
    g = GNNGraph(graph_adjacency_matrix)
    hop_matrix = similar(graph_adjacency_matrix) .= 0
    
    hop_matrix_1 = similar(hop_matrix) .= 1
    hop_matrix_1[diagind(hop_matrix_1)] .= 0

    hop_matrix_2 = [
        0 1 2 2
        1 0 1 2
        2 1 0 1
        2 2 1 0
    ]
    hop_matrix_3 = [
        0 1 2 3
        1 0 1 2
        2 1 0 1
        3 2 1 0
    ]

    result1 = update_hop_matrix!(hop_matrix, g) |> copy
    result2 = update_hop_matrix!(hop_matrix, g) |> copy
    result3 = update_hop_matrix!(hop_matrix, g) |> copy
    result4 = update_hop_matrix!(hop_matrix, g)

    @test result1 == hop_matrix_1
    @test result2 == hop_matrix_2
    @test result3 == hop_matrix_3
    @test result4 == hop_matrix_3
    @test result4 === hop_matrix
    @test result4 == final_hop_matrix(g)
end


@testset "map_shortest_paths_to_neighbors" begin
    graph_adjacency_matrix = [
        0 1 0 1
        1 0 1 0
        0 1 0 1
        1 0 1 0
    ]
    g = GNNGraph(graph_adjacency_matrix)
    shortest_paths_to_neighbors = [
        [Int[], [2], [2, 4], [4]],
        [[1], Int[], [3], [1, 3]],
        [[2, 4], [2], Int[], [4]],
        [[1], [1, 3], [3], Int[]]
    ]

    hop_matrix = final_hop_matrix(g)

    result = map_shortest_paths_to_neighbors(g, hop_matrix)

    @test result == shortest_paths_to_neighbors
    

    @test find_next_step(1, 2, shortest_paths_to_neighbors) == 2
    @test find_next_step(1, 3, shortest_paths_to_neighbors) ∈ [2, 4]
    @test find_next_step(1, 4, shortest_paths_to_neighbors) == 4
    @test find_next_step(4, 2, shortest_paths_to_neighbors) ∈ [1, 3]
end