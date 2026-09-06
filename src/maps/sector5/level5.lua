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
  nextobjectid = 90,
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
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
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
          x = 64,
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
          x = 64,
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
          id = 72,
          name = "Cursor",
          type = "",
          shape = "rectangle",
          x = -192,
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
          id = 73,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 256,
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
          id = 74,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "spawnSaw",
            ["radius"] = 64
          }
        },
        {
          id = 75,
          name = "Portal",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 160,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["pair"] = 1
          }
        },
        {
          id = 76,
          name = "Portal",
          type = "",
          shape = "rectangle",
          x = 128,
          y = 256,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["pair"] = 1
          }
        },
        {
          id = 77,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 288,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1,
            ["intermiTime"] = 1
          }
        },
        {
          id = 78,
          name = "Laser",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 448,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["group"] = 1,
            ["intermiTime"] = 1
          }
        },
        {
          id = 81,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isCounterclockwise"] = true,
            ["speed"] = 5,
            ["width"] = 3
          }
        },
        {
          id = 82,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isCounterclockwise"] = true,
            ["speed"] = 5,
            ["width"] = 3
          }
        },
        {
          id = 83,
          name = "SpinningPlat",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 1,
          visible = true,
          properties = {
            ["isCounterclockwise"] = true,
            ["speed"] = 5,
            ["width"] = 3
          }
        },
        {
          id = 84,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "spawnSaw",
            ["radius"] = 64
          }
        },
        {
          id = 85,
          name = "Booster",
          type = "",
          shape = "rectangle",
          x = 448,
          y = 144,
          width = 32,
          height = 32,
          rotation = -90,
          opacity = 1,
          gid = 8,
          visible = true,
          properties = {
            ["speed"] = 2500
          }
        },
        {
          id = 87,
          name = "InviSpike",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 608,
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
          id = 88,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 384,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "spawnLaser",
            ["radius"] = 64
          }
        },
        {
          id = 89,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 448,
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
