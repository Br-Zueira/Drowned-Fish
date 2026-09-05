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
  nextobjectid = 70,
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
      tilecount = 8,
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
        },
        {
          id = 6,
          type = "Spring",
          image = "../../assets/images/spring.png",
          width = 32,
          height = 32
        },
        {
          id = 7,
          type = "Booster",
          image = "../../assets/images/booster.png",
          width = 32,
          height = 32
        },
        {
          id = 8,
          type = "Laser",
          image = "../../assets/images/laser.png",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1
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
          x = 32,
          y = 32,
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
          x = 896,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 5,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "overflow",
            ["radius"] = 64
          }
        },
        {
          id = 42,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 43,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 44,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 45,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 46,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = true,
            ["radius"] = 64
          }
        },
        {
          id = 47,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 49,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 100
          }
        },
        {
          id = 50,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 704,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = true,
            ["radius"] = 64
          }
        },
        {
          id = 51,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 928,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1
          }
        },
        {
          id = 52,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1
          }
        },
        {
          id = 53,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = true,
            ["radius"] = 48
          }
        },
        {
          id = 54,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = true,
            ["radius"] = 64
          }
        },
        {
          id = 56,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 48
          }
        },
        {
          id = 57,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 48
          }
        },
        {
          id = 58,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 0
          }
        },
        {
          id = 59,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = -192,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 0
          }
        },
        {
          id = 60,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 320,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {
            ["radius"] = 48
          }
        },
        {
          id = 61,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 48
          }
        },
        {
          id = 62,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 48
          }
        },
        {
          id = 63,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = true,
            ["radius"] = 48
          }
        },
        {
          id = 64,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isUp"] = false,
            ["radius"] = 48
          }
        },
        {
          id = 65,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["endX"] = 1024,
            ["radius"] = 128
          }
        },
        {
          id = 67,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["endX"] = 1024,
            ["radius"] = 128
          }
        },
        {
          id = 68,
          name = "FallTile",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 544,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["endX"] = 1024,
            ["radius"] = 128
          }
        }
      }
    }
  }
}
