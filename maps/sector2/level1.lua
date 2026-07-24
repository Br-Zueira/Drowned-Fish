return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.12.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 30,
  height = 20,
  tilewidth = 32,
  tileheight = 32,
  nextlayerid = 3,
  nextobjectid = 12,
  properties = {},
  tilesets = {
    {
      name = "Props",
      firstgid = 1,
      class = "Saw",
      tilewidth = 32,
      tileheight = 32,
      spacing = 0,
      margin = 0,
      columns = 0,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {},
      wangsets = {},
      tilecount = 5,
      tiles = {
        {
          id = 0,
          type = "Tile",
          image = "../../assets/images/test.png",
          width = 32,
          height = 32
        },
        {
          id = 1,
          type = "Placeholder",
          image = "../../assets/images/placeholder.png",
          width = 32,
          height = 32
        },
        {
          id = 3,
          type = "Spike",
          image = "../../assets/images/spike.png",
          width = 32,
          height = 16
        },
        {
          id = 4,
          type = "Goal",
          image = "../../assets/images/goal.png",
          width = 32,
          height = 32
        },
        {
          id = 5,
          type = "Saw",
          image = "../../assets/images/saw.png",
          width = 32,
          height = 32
        }
      }
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 30,
      height = 20,
      id = 1,
      name = "Layout",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "Objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 1,
          name = "Spawnpoint",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 64,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "Goal",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 5,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "MovPlat",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["speed"] = 100
          }
        },
        {
          id = 6,
          name = "SpawnSaw",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["order"] = 1,
            ["speed"] = 100
          }
        },
        {
          id = 7,
          name = "SpawnSaw",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["order"] = 2,
            ["speed"] = 100
          }
        },
        {
          id = 8,
          name = "SpawnSaw",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 480,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["order"] = 3,
            ["speed"] = 100
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 320,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "SpawnSaw",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 512,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["order"] = 4,
            ["speed"] = 100
          }
        },
        {
          id = 11,
          name = "SpawnSaw",
          type = "",
          shape = "rectangle",
          x = -64,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["isFake"] = true,
            ["order"] = 5,
            ["speed"] = 100
          }
        }
      }
    }
  }
}
