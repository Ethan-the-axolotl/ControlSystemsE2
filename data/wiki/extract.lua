local common = require('common')

local API = {
  NAME = "FSensor",
  POOL = {
    {name="MAKE",cols={"Instance creator", "R", "Description"}},
    {name="APPLY",cols={"Method/Function", "R", "Description"}},
  },
  TYPE = {
    __pic = false,
    __obj = "xfs",
    __key = "###", -- The key tells what patterns to be replaced
    link = "![image](https://raw.githubusercontent.com/dvdvideo1234/ControlSystemsE2/master/data/pictures/types/type-###.jpg)",
    notype = "xxx"
  },

  REPLACE = {
    __key = "###", -- The key tells what patterns to be replaced
    ["MASK"] = "[###](https://wiki.garrysmod.com/page/Enums/###)",
    ["COLLISION_GROUP"] = "[COLLISION_GROUP](https://wiki.garrysmod.com/page/Enums/###)"
  }
}

API.RETURN = {
  PREF = {
    ["set"] = API.TYPE.__obj,
    ["upd"] = API.TYPE.__obj,
    ["smp"] = API.TYPE.__obj,
    ["add"] = API.TYPE.__obj,
    ["rem"] = API.TYPE.__obj,
    ["no"]  = API.TYPE.__obj,
    ["new"] = API.TYPE.__obj,
    ["is"] = "n"
  },
  MATCH = {}
}

local E2Helper = {}
E2Helper.Descriptions = {}

------------------------------------------------------PUT E2 DESCRIPTION HERE------------------------------------------------------

------------------------------------------------------PUT E2 DESCRIPTION HERE------------------------------------------------------

if(DSC) then
  local t = API.POOL[1]
  for n in pairs(DSC) do
    if(n:find(API.NAME)) then t = API.POOL[1] else t = API.POOL[2] end
    DSC[n] = DSC[n]:gsub("/","`")
    for k in pairs(API.REPLACE) do
      if(DSC[n]:find(k)) then
        DSC[n] = DSC[n]:gsub(k, API.REPLACE[k]:gsub(API.REPLACE.__key, k))
      end
    end
    table.insert(t, n)
  end
  
  local function printRow(tT)
    io.write("\n|"..table.concat(tT, "|").."|")
  end
  
  local function concatType(sT, bP, bD)
    if(bD) then return "" end
    local sV = tostring(sT)
    if(sV:sub(1,1) == "/") then sV = sV:sub(2,-1) end
    bU = common.getPick(bP ~= nil, bP, API.TYPE.__pic)
    if(bU) then 
      local exp = common.stringExplode(sV, "/")
      for iN = 1, #exp do
        exp[iN] = API.TYPE.link:gsub(API.TYPE.__key, exp[iN])
      end
      return table.concat(exp, " ")
    else
      return sV
    end
  end
  
  local function readReturnFalues(sP) 
    local fR = io.open(tostring(sP), "r")
    if(not fR) then return end
    local sL = fR:read("*line")
    while(sL ~= nil) do
      local sT = common.stringTrim(sL)
      if(sL ~= "") then
        local tT = common.stringExplode(sT, ":")
        tT[1] = common.stringTrim(tostring(tT[1]))
        tT[2] = common.stringTrim(tostring(tT[2]))
        API.RETURN.MATCH[tT[1]] = tT[2]
      end
      sL = fR:read("*line")
    end
  end
  
  local function printDescriptionTable(iN)
    local tPool = API.POOL[iN]
    if(not tPool) then return end
    local nC = #tPool.cols; table.sort(tPool); tPool.data = {}
    printRow(tPool.cols); io.write("\n|"..("---|"):rep(nC))
    for i, n in ipairs(tPool) do
      local arg, vars, obj, ret = n:match("%(.-%)"), "", "", ""
      if(arg) then arg = arg:sub(2,-2)
        local tsk = common.stringExplode(arg,":")
        if(not arg:find(":")) then
          tsk[2], tsk[1] = tsk[1], API.TYPE.notype end
        if(tsk[2] == "") then tsk[2] = API.TYPE.notype end
        tsk[1], tsk[2] = common.stringTrim(tsk[1]), common.stringTrim(tsk[2])
        local k, len = 1, tsk[2]:len(); obj = "/"..tsk[1]
        while(k <= len) do local sbc = tsk[2]:sub(k,k)
          if(sbc == "x") then
            sbc = tsk[2]:sub(k,k+2)
            k = (k + 2) -- The end of the current type
          end; k = (k + 1)
          vars = vars.."/"..sbc
        end
      end
            
      local cap, mch = n:find("%L"), ""
      for rmk, rmv in pairs(API.RETURN.MATCH) do
        if(n:find(rmk)) then ret = rmv; break end
      end
      
      if(ret == "") then
        if(n:find(API.NAME)) then
          ret = "/"..API.TYPE.__obj
        elseif(cap and API.RETURN.PREF[n:sub(1,cap-1)]) then
          ret = "/"..API.RETURN.PREF[n:sub(1,cap-1)]
        else
          ret = "/"..API.TYPE.notype
        end
      end
      if(obj:find(API.TYPE.notype)) then
        printRow({n:gsub("%(.-%)", "("..concatType(vars, true)..")"), concatType(ret, true), DSC[n]})      
      else
        printRow({concatType(obj, true)..":"..n:gsub("%(.-%)", "("..concatType(vars, true)..")"), concatType(ret, true), DSC[n]})      
      end
    end
    io.write("\n")
  end
  
  readReturnFalues("E:/Documents/Lua-Projs/SVN/ControlSystemsE2/data/wiki/fsensor_rt.txt")
  printDescriptionTable(1)
  printDescriptionTable(2)

else
  print("Only God can create something from nothing. Do not expect this script to be God :P")
end