"""
    propagate_speeds!(speeds_flow_step, speeds_start)

update speeds for every flow and channel  
u[flow][start] := speeds_start[flow]  
u[flow][channel] := u[flow][channel - 1]  
"""
function propagate_speeds!(speeds_flow_step, speeds_start)
    foreach(speeds_flow_step, speeds_start) do speeds_step, speed_start
        # for each flow
        speeds_step[2:end] = speeds_step[1:end - 1]
        speeds_step[1] = speed_start
    end
    speeds_flow_step
end


"""
    channels_load(speeds_flow_step, channels_to_flow_steps)

return load for each channel  
`channels_to_flow_steps` maps channel to flows and index of channel in flow  
load equals sum of all speeds
"""
function channels_load(speeds_flow_step, channels_to_flow_steps)
    map(channels_to_flow_steps) do (flows, channels)
        mapreduce(+, flows, channels) do flow, channel
            # @show flow, channel
            speeds_flow_step[flow][channel]
        end
    end
end


"""
    regulate_speed!(speeds_flow_step, current_channels_load, flow_steps_to_channel, max_channels_load)

regulate speed for each flow and channel so channel_loads ≤ max_channels_load
"""
function regulate_speed!(speeds_flow_step, current_channels_load, flow_steps_to_channel, max_channels_load)
    coefficients = @. min(max_channels_load / current_channels_load, 1)
    foreach(speeds_flow_step, flow_steps_to_channel) do speeds_step, steps_to_channel
        # for each flow
        # adjust speed so channel load <= max channel load
        speeds_step .*= coefficients[steps_to_channel]
    end
    speeds_flow_step
end


"""
    update_speed!(
        speeds_flow_step,
        speeds_start,
        channels_to_flow_steps,
        flow_steps_to_channel,
        max_channels_load
)

update all speed for every flow and step  
guaranteed that channel load ≤ max channel load
"""
function update_speed!(
    speeds_flow_step,
    speeds_start,
    channels_to_flow_steps,
    flow_steps_to_channel,
    max_channels_load
)
    propagate_speeds!(speeds_flow_step, speeds_start)
    current_channel_loads = channels_load(speeds_flow_step, channels_to_flow_steps)
    regulate_speed!(speeds_flow_step, current_channel_loads, flow_steps_to_channel, max_channels_load)
    speeds_flow_step
end