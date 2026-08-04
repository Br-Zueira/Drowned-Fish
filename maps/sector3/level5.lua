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
  nextobjectid = 64,
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
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1,
        1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
        1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1
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
          x = 96,
          y = 576,
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
          x = 896,
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
          id = 52,
          name = "LaserPoint",
          type = "",
          shape = "rectangle",
          x = -32,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["point"] = 1
          }
        },
        {
          id = 53,
          name = "LaserPoint",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 9,
          visible = true,
          properties = {
            ["point"] = 3
          }
        },
        {
          id = 58,
          name = "LaserPoint",
          type = "",
          shape = "rectangle",
          x = -32,
          y = 672,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["point"] = 2
          }
        },
        {
          id = 59,
          name = "LaserPoint",
          type = "",
          shape = "rectangle",
          x = 960,
          y = 0,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["point"] = 4
          }
        },
        {
          id = 60,
          name = "Spring",
          type = "",
          shape = "rectangle",
          x = 768,
          y = 640,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 7,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "Booster",
          type = "",
          shape = "rectangle",
          x = 864,
          y = 480,
          width = 32,
          height = 32,
          rotation = 315,
          opacity = 1,
          gid = 8,
          visible = true,
          properties = {
            ["speed"] = 2000
          }
        },
        {
          id = 62,
          name = "Trigger",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 224,
          width = 32,
          height = 32,
          rotation = 0,
          opacity = 1,
          gid = 2,
          visible = true,
          properties = {
            ["id"] = "invertLaser",
            ["radius"] = 64
          }
        }
      }
    }
  }
}
