mutable struct Trie_Node
    char::Char
    children::Union{Int, Vector{Int}}
    accept_flag::Bool
    length::Int
end


struct Trie
    nodes::Vector{Trie_Node}

    function Trie()
        new([Trie_Node('#', -1, false, 0)])
    end
end

function Trie(word::String)
    trie = Trie()
    insert!(trie, word)
    return trie
end


function insert!(trie::Trie, word::String)
    function helper!(index::Int, char::Char, accept_flag::Bool, trie::Trie,)
        # nodeの下にcharをcharに持つTrie_Nodeを追加する
        node = trie.nodes[index]

        if node.children isa Int
            push!(trie.nodes, Trie_Node(char, -1, accept_flag, node.length + 1))
            trie.nodes[index].children = [length(trie.nodes)]
            return length(trie.nodes)
        end

        
        for i in node.children
            if trie.nodes[i].char == char
                if accept_flag
                    trie.nodes[i].accept_flag = true
                end
                return i
            end
        end

        push!(trie.nodes, Trie_Node(char, -1, accept_flag, node.length + 1))
        push!(trie.nodes[index].children, length(trie.nodes))

        return length(trie.nodes)
        
    end

    search_index = 1
    for (i, c) in enumerate(word)
        accept_flag = i == length(word)
        search_index = helper!(search_index, c, accept_flag, trie)
    end
end


function Base.show(io::IO, node::Trie_Node)
    println("character: ", node.char)
    println("children: ", node.children)
    println("accept_flag: ", node.accept_flag)
end

function Base.show(io::IO, trie::Trie)
    function helper(node::Trie_Node, text::String, trie::Trie)
        println(text * node.char, node.accept_flag ? " (accept)" : "")

        if node.children isa Int
            return
        else
            for i in node.children
                helper(trie.nodes[i], text * node.char, trie)
            end
        end
    end

    if trie.nodes[1].children isa Int
        println("root")
        return
    end

    for i in trie.nodes[1].children
        text = ""
        helper(trie.nodes[i], text, trie)
    end
end

function listup(trie::Trie)
    word_list = []

    function helper(node::Trie_Node, text::String, trie::Trie)
        if node.accept_flag
            push!(word_list, text * node.char)
        end

        if node.children isa Int
            return
        else
            for i in node.children
                helper(trie.nodes[i], text * node.char, trie)
            end
        end
    end

    for i in trie.nodes[1].children
        text = ""
        helper(trie.nodes[i], text, trie)
    end

    return word_list
end

function get_next_char(trie::Trie, node::Trie_Node)
    if node.children isa Int
        return []
    else
        return [trie.nodes[i].char for i in node.children]
    end
end


function search(trie::Trie, word::String)
    search_index = 1
    for (i, char) in enumerate(word)
        node = trie.nodes[search_index]
        if node.children isa Int
            return false
        end

        for j in node.children
            if trie.nodes[j].char == char
                search_index = j
                break
            end
        end
    end

    return trie.nodes[search_index].accept_flag

end
