"""
    update_hop_matrix!(hop_matrix, g)

distributed (local) update of hop matrix  

after L updates since last graph change  
hop matrix is guaranteed to provide true hop distances  
where L - maximum length of shortest paths
"""
function update_hop_matrix!(hop_matrix, g)
    hop_matrix .= propagate(copy_xj, g, min; xj = hop_matrix) .+ 1
    hop_matrix[diagind(hop_matrix)] .= 0
    hop_matrix
end


"""
    final_hop_matrix(g, [hop_matrix])

return final hop-distance matrix for graph g
"""
function final_hop_matrix(g, hop_matrix = zeros(Int, nv(g), nv(g)))
    for _ in 1:nv(g)
        update_hop_matrix!(hop_matrix, g)
    end
    hop_matrix
end


"""
    map_shortest_paths_to_neighbors(g, hop_matrix)

return `vector{vector{vector{Int}}}` - [source][target][neighbor]  
map each pair of (source, target) to subset of source neighbors  
who are part of one of the shortest path from source to target
"""
function map_shortest_paths_to_neighbors(g, hop_matrix)
    src, dst = edge_index(g)
    neighbor_distance = apply_edges(copy_xj, g; xj = hop_matrix)

    map(1:nv(g)) do source
        source_edge_indices = findall(isequal(source), dst)
        source_neighbors = src[source_edge_indices]
        map(1:nv(g)) do target
            if source == target
                return Int[]
            end
            target_distance_from_neighbor = neighbor_distance[target, source_edge_indices]
            min_distance = minimum(target_distance_from_neighbor)
            argmin_distance = findall(isequal(min_distance), target_distance_from_neighbor)
            source_neighbors[argmin_distance]
        end
    end
end


"""
    find_next_step(source, target, shortest_paths_to_neighbors)

return random neighbor lying on the shortest path
"""
function find_next_step(source, target, shortest_paths_to_neighbors)
    variants = shortest_paths_to_neighbors[source][target]
    rand(variants)
end


"""
    find_flow_path(source, target, shortest_paths_to_neighbors)

return vector of nodes including source and target nodes  
guaranteed to have minimum length
"""
function find_flow_path(source, target, shortest_paths_to_neighbors)
    flow = [source]
    for _ in 1:length(shortest_paths_to_neighbors)
        if flow[end] == target
            return flow
        end
        push!(flow, find_next_step(flow[end], target, shortest_paths_to_neighbors))
    end
    @error "No path found" source target
    error("find_flow_path")
end


function node_path_to_channels_path(path, g)
    s, t = edge_index(g)
    map(path[1:end - 1], path[2:end]) do source, target
        A = s .== source
        B = t .== target
        findfirst(A .& B)
    end
end