function map_channels_to_flow_steps(flow_steps_to_channel, channel_number)
    flows = Dict(k => Int[] for k in 1:channel_number)
    steps = Dict(k => Int[] for k in 1:channel_number)
    foreach(flow_steps_to_channel, 1:length(flow_steps_to_channel)) do channel_indices, flow_index
        foreach(channel_indices, 1:length(channel_indices)) do channel_index, step_index
            push!(flows[channel_index], flow_index)
            push!(steps[channel_index], step_index)
        end
    end
    map(1:channel_number) do channel_index
        (flows[channel_index], steps[channel_index])
    end
end