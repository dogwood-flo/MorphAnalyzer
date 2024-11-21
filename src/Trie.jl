module SubTrie

mutable struct Trie_Node
    char::Char
    children::Union{Int, Vector{Int}}
    accept_flag::Bool
end


struct Trie
    nodes::Vector{Trie_Node}

    function Trie()
        new([Trie_Node('#', -1, false)])
    end
end

function Trie(word::String)
    trie = Trie()
    insert!(trie, word)
    return trie
end

function next_node(c::Char, node::Trie_Node, trie::Trie)
    if node.children isa Int
        return -1
    end
    for i in node.children
        if trie.nodes[i].char == c
            return i
        end
    end
    return -1
end


function insert!(trie::Trie, word::String)
    index = 1
    for (i, c) in enumerate(word)
        next_node_index = next_node(c, trie.nodes[index], trie)
        if next_node_index == -1
            next_node_index = length(trie.nodes) + 1

            if i == length(word)
                push!(trie.nodes, Trie_Node(c, -1, true))
            else
                push!(trie.nodes, Trie_Node(c, -1, false))
            end

            if trie.nodes[index].children == -1
                trie.nodes[index].children = [next_node_index]
            else
                push!(trie.nodes[index].children, next_node_index)
            end
            
        end
        index = next_node_index
    end
end

function Base.show(io::IO, node::Trie_Node)
    print("character: $(node.char)")
    if node.accept_flag
        print(" accept_flag: true")
    end
end

function Base.show(io::IO, trie::Trie)
    for node in trie.nodes
        println(node)
    end
end

end # module SubTrie