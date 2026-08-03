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
  nextobjectid = 52,
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
        1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
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
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1,
            ["intermiTime"] = 2
          }
        },
        {
          id = 2,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1,
            ["intermiTime"] = 2
          }
        },
        {
          id = 3,
          name = "Spawnpoint",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 96,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Goal",
          type = "",
          shape = "rectangle",
          x = 864,
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
          id = 6,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 2,
            ["intermiTime"] = 1
          }
        },
        {
          id = 7,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 2,
            ["intermiTime"] = 1
          }
        },
        {
          id = 8,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 3
          }
        },
        {
          id = 9,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 3
          }
        },
        {
          id = 10,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 352,
          y = -32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 512,
          y = -32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 4,
            ["isFake"] = true
          }
        },
        {
          id = 29,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 128,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 4,
            ["isFake"] = true
          }
        },
        {
          id = 30,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 608,
          y = -32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 832,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "Saw",
          type = "",
          shape = "rectangle",
          x = 832,
          y = -32,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "spawnSaws",
            ["radius"] = 64
          }
        },
        {
          id = 35,
          name = "MovLaser",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["endY"] = 160,
            ["group"] = 5,
            ["speed"] = 250
          }
        },
        {
          id = 36,
          name = "MovLaser",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["endY"] = 256,
            ["group"] = 5,
            ["speed"] = 250
          }
        },
        {
          id = 37,
          name = "FutureLaser",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["endY"] = 256,
            ["group"] = 5,
            ["speed"] = 50
          }
        },
        {
          id = 38,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "futureLaser",
            ["radius"] = 64
          }
        },
        {
          id = 39,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6,
            ["intermiTime"] = 1
          }
        },
        {
          id = 41,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6
          }
        },
        {
          id = 42,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6,
            ["intermiTime"] = 1,
            ["isDisabled"] = true
          }
        },
        {
          id = 43,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6
          }
        },
        {
          id = 44,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6,
            ["intermiTime"] = 1,
            ["isDisabled"] = true
          }
        },
        {
          id = 48,
          name = "Spike",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 608,
          width = 32,
          height = 16,
          rotation = 0,
          opacity = 1,
          gid = 4,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 896,
          y = 608,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 6,
            ["intermiTime"] = 1
          }
        }
      }
    }
  }
}
