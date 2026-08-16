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
  nextobjectid = 23,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          y = 608,
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
          x = 32,
          y = 96,
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
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 192,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["height"] = 2,
            ["speed"] = 5,
            ["width"] = 2
          }
        },
        {
          id = 4,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["height"] = 2,
            ["speed"] = 5,
            ["width"] = 2
          }
        },
        {
          id = 5,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 576,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["height"] = 4,
            ["isCounterclockwise"] = true,
            ["speed"] = 3,
            ["width"] = 4
          }
        },
        {
          id = 6,
          name = "MovSpinningPlat",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isCounterclockwise"] = true,
            ["rotationSpeed"] = 3,
            ["speed"] = 100,
            ["width"] = 5
          }
        },
        {
          id = 7,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 576,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["speed"] = 7,
            ["width"] = 2
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 160,
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
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 352,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "speedup",
            ["radius"] = 64
          }
        },
        {
          id = 11,
          name = "FakeMoverSaw",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 416,
            ["endY"] = 128,
            ["speed"] = 250
          }
        },
        {
          id = 14,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = -128,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["grous"] = 1
          }
        },
        {
          id = 15,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 736,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["grous"] = 1
          }
        },
        {
          id = 16,
          name = "FakeMoverSaw",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 544,
            ["endY"] = 128,
            ["speed"] = 250
          }
        },
        {
          id = 17,
          name = "FakeMoverSaw",
          type = "",
          shape = "rectangle",
          x = 672,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 672,
            ["endY"] = 128,
            ["speed"] = 250
          }
        },
        {
          id = 18,
          name = "FakeMoverSaw",
          type = "",
          shape = "rectangle",
          x = 272,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 6,
          visible = true,
          properties = {
            ["endX"] = 272,
            ["endY"] = 128,
            ["speed"] = 250
          }
        },
        {
          id = 19,
          name = "DeadlyTile",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "DeadlyTile",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "DeadlyTile",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
