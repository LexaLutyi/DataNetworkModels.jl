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