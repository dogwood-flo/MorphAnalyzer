include("../src/Trie.jl")
using Main.SubTrie


trie = SubTrie.Trie()
SubTrie.insert!(trie, "hello")
SubTrie.insert!(trie, "world")
SubTrie.insert!(trie, "hell")
SubTrie.insert!(trie, "worlds")
SubTrie.insert!(trie, "workspace")

SubTrie.print(trie)