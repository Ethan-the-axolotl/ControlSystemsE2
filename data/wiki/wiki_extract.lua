local common = require('common')
common.addPathLibrary("E:/Documents/Lua-Projs/ZeroBraineIDE/myprograms/wiki-extract","*.lua")
local wikilib = require('wikilib')

local API = {
  NAME = "StControl",
  SETS = {
    __err = true
  },
  POOL = {
    {name="MAKE",cols={"Instance.creator", "Out", "Description"},size={50,5,13}},
    {name="APPLY",cols={"Class.methods", "Out", "Description"},size={50,5,13}},
  },
  FILE = {
    base = "E:/Documents/Lua-Projs/SVN/ControlSystemsE2/",
    path = "data/wiki",
    slua = "lua/entities/gmod_wire_expression2/core/custom"
  },
  TYPE = {
    E2 = "stcontrol",
    __obj = "xsc",
    __pic = false,
    __tfm = "type-%s.jpg",
    __rty = "ref-%s",
    __rbr = "[ref-%s]: %s",
    __ref = "![ref-%s]: %s",
    __img = "![image][%s]",
    link = "https://raw.githubusercontent.com/dvdvideo1234/ControlSystemsE2/master/data/pictures/types/%s",
  },

  REPLACE = {
    __key = "###", -- The key tells what patterns to be replaced
    ["MASK"] = "[###](https://wiki.garrysmod.com/page/Enums/###)",
    ["COLLISION_GROUP"] = "[COLLISION_GROUP](https://wiki.garrysmod.com/page/Enums/###)"
  }
}

local E2Helper = {}
E2Helper.Descriptions = {}

------------------------------------------------------PUT E2 DESCRIPTION HERE------------------------------------------------------


------------------------------------------------------PUT E2 DESCRIPTION HERE------------------------------------------------------
wikilib.setInternalType(API)
wikilib.updateAPI(API, DSC)
wikilib.makeReturnValues(API)
wikilib.printDescriptionTable(API, DSC, 1)
wikilib.printDescriptionTable(API, DSC, 2)
wikilib.printTypeReference(API)
wikilib.printTypeTable(API)
