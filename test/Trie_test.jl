include("../src/Trie.jl")

trie = Trie()
insert!(trie, "hello")
insert!(trie, "world")
insert!(trie, "hell")
insert!(trie, "worlds")
insert!(trie, "workspace")

print(trie)
listup(trie)