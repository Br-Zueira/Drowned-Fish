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
  nextlayerid = 4,
  nextobjectid = 44,
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1
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
          id = 3,
          name = "Spawnpoint",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "Goal",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 5,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "MoverSaw",
          type = "",
          shape = "rectangle",
          x = 336,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 336,
            ["endY"] = 672,
            ["isOneWay"] = true,
            ["speed"] = 500
          }
        },
        {
          id = 29,
          name = "MoverSaw",
          type = "",
          shape = "rectangle",
          x = 528,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 528,
            ["endY"] = 672,
            ["isOneWay"] = true,
            ["speed"] = 500
          }
        },
        {
          id = 30,
          name = "MoverSaw",
          type = "",
          shape = "rectangle",
          x = 639,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 639,
            ["endY"] = 0,
            ["isOneWay"] = true,
            ["speed"] = 500
          }
        },
        {
          id = 31,
          name = "MoverSaw",
          type = "",
          shape = "rectangle",
          x = 432,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 432,
            ["endY"] = 0,
            ["isOneWay"] = true,
            ["speed"] = 500
          }
        },
        {
          id = 33,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 35,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 36,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 37,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 38,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 39,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 448,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 64
          }
        },
        {
          id = 41,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 416,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "moreSaws",
            ["radius"] = 64
          }
        },
        {
          id = 42,
          name = "",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
