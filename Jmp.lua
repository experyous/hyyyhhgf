local g = {}
g.last = gg.getFile()
g.info = nil
g.config = gg.EXT_CACHE_DIR .. "/" .. gg.getFile():match("[^/]+$") .. ".2.cfg"
g.KNTL = loadfile(g.config)
if g.KNTL ~= nil then g.info = g.KNTL() g.KNTL = nil end
if g.info == nil then g.info = {g.last, g.last:gsub("/[^/]+$", "")} end

while true do
g.info = gg.prompt({"Select File .lasm","Path Output"},g.info,{"file","path"})
if not g.info then 
  gg.setVisible(true)
  os.exit(print("Script Cancelled"))
end
checkfi = g.info[1]:match(".-(.-).lasm")
if checkfi == nil then
  gg.alert("Please Select file .lasm","")
  os.exit()
else
gg.saveVariable(g.info, g.config)
g.last = g.info[1]
if io.open(g.last, "r") == nil then
  os.exit(gg.alert("⚠️Script not Found! ⚠️"))
else
  g.out = g.last:match("[^/]+$")
  g.out = g.out:gsub(".lua.-(.-).lasm", "")
  g.out = g.out:gsub(".lasm","")
  g.out = g.info[2] .. "/" .. g.out .. ".jmp666.lasm"
  
end
DoneEX = "Fixed\n\n📂 Output : "..g.out
DATA=io.open(g.last, "r"):read("*a")
DATA = string.gsub(DATA, ".source \"[^\n]*",".source \"bnt\"")
DATA = string.gsub(DATA, "\t","")
DATA=string.gsub(DATA, ".linedefined [^\n]*\n.lastlinedefined [^\n]*\n.numparams [^\n]*\n.is_vararg [^\n]*\n.maxstacksize [^\n]*\n.end ; F",".linedefined 21\n.lastlinedefined 21\n.numparams 21\n.is_vararg 21\n.maxstacksize 21\n\nLOADK v0 \"bnttx\"\n\nRETURN\n.end ; F")

DATA=DATA:gsub("linedefined [^\n]*","linedefined 0"):gsub("lastlinedefined [^\n]*","lastlinedefined 0"):gsub("numparams [^\n]*","numparams 0"):gsub("\t",""):gsub("\n\n","\n"):gsub("[^\n]*RETURN  ; garbage\n","")
DATA=DATA:gsub(".maxstacksize [^\n]*\n.end",".maxstacksize 250\nRETURN\n.end\n")
DATA = DATA:gsub("[^\n]*JMP :goto_[^\n]*; %+[^\n]* ↓\n", "")
DATA = DATA:gsub("[^\n]*JMP :goto_[^\n]*; %-[^\n]* ↑\n", "")
DATA = DATA:gsub("[^\n]*:goto_[^\n]*\n", "")

io.open(g.out, "w"):write(DATA):close()
gg.setVisible(true)
print(DoneEX)
return gg.alert(DoneEX)
end
end
 