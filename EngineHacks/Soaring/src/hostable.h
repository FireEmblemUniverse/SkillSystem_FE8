#ifndef __HOSTABLE__
#define __HOSTABLE__

//list of tables - one for each camera position

#define min(a, b) (((a) < (b)) ? (a) : (b))
#define max(a, b) (((a) > (b)) ? (a) : (b))

#define HOS_CELL(cam_z, z_dist, p_height) \
  min(MODE5_WIDTH, max(0, (((p_height-cam_z)<<SCALING_FACTOR)/(z_dist>>1)) + HORIZON)) //prevent division by 0 by lsh and rsh

#define HOS_ROW(cam_z, z_dist) {\
  HOS_CELL(cam_z, z_dist, 0x0),   \
  HOS_CELL(cam_z, z_dist, 0x1),   \
  HOS_CELL(cam_z, z_dist, 0x2),   \
  HOS_CELL(cam_z, z_dist, 0x3),   \
  HOS_CELL(cam_z, z_dist, 0x4),   \
  HOS_CELL(cam_z, z_dist, 0x5),   \
  HOS_CELL(cam_z, z_dist, 0x6),   \
  HOS_CELL(cam_z, z_dist, 0x7),   \
  HOS_CELL(cam_z, z_dist, 0x8),   \
  HOS_CELL(cam_z, z_dist, 0x9),   \
  HOS_CELL(cam_z, z_dist, 0xA),   \
  HOS_CELL(cam_z, z_dist, 0xB),   \
  HOS_CELL(cam_z, z_dist, 0xC),   \
  HOS_CELL(cam_z, z_dist, 0xD),   \
  HOS_CELL(cam_z, z_dist, 0xE),   \
  HOS_CELL(cam_z, z_dist, 0xF),   \
  HOS_CELL(cam_z, z_dist, 0x10),   \
  HOS_CELL(cam_z, z_dist, 0x11),   \
  HOS_CELL(cam_z, z_dist, 0x12),   \
  HOS_CELL(cam_z, z_dist, 0x13),   \
  HOS_CELL(cam_z, z_dist, 0x14),   \
  HOS_CELL(cam_z, z_dist, 0x15),   \
  HOS_CELL(cam_z, z_dist, 0x16),   \
  HOS_CELL(cam_z, z_dist, 0x17),   \
  HOS_CELL(cam_z, z_dist, 0x18),   \
  HOS_CELL(cam_z, z_dist, 0x19),   \
  HOS_CELL(cam_z, z_dist, 0x1A),   \
  HOS_CELL(cam_z, z_dist, 0x1B),   \
  HOS_CELL(cam_z, z_dist, 0x1C),   \
  HOS_CELL(cam_z, z_dist, 0x1D),   \
  HOS_CELL(cam_z, z_dist, 0x1E),   \
  HOS_CELL(cam_z, z_dist, 0x1F),   \
  HOS_CELL(cam_z, z_dist, 0x20),   \
  HOS_CELL(cam_z, z_dist, 0x21),   \
  HOS_CELL(cam_z, z_dist, 0x22),   \
  HOS_CELL(cam_z, z_dist, 0x23),   \
  HOS_CELL(cam_z, z_dist, 0x24),   \
  HOS_CELL(cam_z, z_dist, 0x25),   \
  HOS_CELL(cam_z, z_dist, 0x26),   \
  HOS_CELL(cam_z, z_dist, 0x27),   \
  HOS_CELL(cam_z, z_dist, 0x28),   \
  HOS_CELL(cam_z, z_dist, 0x29),   \
  HOS_CELL(cam_z, z_dist, 0x2A),   \
  HOS_CELL(cam_z, z_dist, 0x2B),   \
  HOS_CELL(cam_z, z_dist, 0x2C),   \
  HOS_CELL(cam_z, z_dist, 0x2D),   \
  HOS_CELL(cam_z, z_dist, 0x2E),   \
  HOS_CELL(cam_z, z_dist, 0x2F),   \
  HOS_CELL(cam_z, z_dist, 0x30),   \
  HOS_CELL(cam_z, z_dist, 0x31),   \
  HOS_CELL(cam_z, z_dist, 0x32),   \
  HOS_CELL(cam_z, z_dist, 0x33),   \
  HOS_CELL(cam_z, z_dist, 0x34),   \
  HOS_CELL(cam_z, z_dist, 0x35),   \
  HOS_CELL(cam_z, z_dist, 0x36),   \
  HOS_CELL(cam_z, z_dist, 0x37),   \
  HOS_CELL(cam_z, z_dist, 0x38),   \
  HOS_CELL(cam_z, z_dist, 0x39),   \
  HOS_CELL(cam_z, z_dist, 0x3A),   \
  HOS_CELL(cam_z, z_dist, 0x3B),   \
  HOS_CELL(cam_z, z_dist, 0x3C),   \
  HOS_CELL(cam_z, z_dist, 0x3D),   \
  HOS_CELL(cam_z, z_dist, 0x3E),   \
  HOS_CELL(cam_z, z_dist, 0x3F),   \
  HOS_CELL(cam_z, z_dist, 0x40),   \
  HOS_CELL(cam_z, z_dist, 0x41),   \
  HOS_CELL(cam_z, z_dist, 0x42),   \
  HOS_CELL(cam_z, z_dist, 0x43),   \
  HOS_CELL(cam_z, z_dist, 0x44),   \
  HOS_CELL(cam_z, z_dist, 0x45),   \
  HOS_CELL(cam_z, z_dist, 0x46),   \
  HOS_CELL(cam_z, z_dist, 0x47),   \
  HOS_CELL(cam_z, z_dist, 0x48),   \
  HOS_CELL(cam_z, z_dist, 0x49),   \
  HOS_CELL(cam_z, z_dist, 0x4A),   \
  HOS_CELL(cam_z, z_dist, 0x4B),   \
  HOS_CELL(cam_z, z_dist, 0x4C),   \
  HOS_CELL(cam_z, z_dist, 0x4D),   \
  HOS_CELL(cam_z, z_dist, 0x4E),   \
  HOS_CELL(cam_z, z_dist, 0x4F),   \
  HOS_CELL(cam_z, z_dist, 0x50),   \
  HOS_CELL(cam_z, z_dist, 0x51),   \
  HOS_CELL(cam_z, z_dist, 0x52),   \
  HOS_CELL(cam_z, z_dist, 0x53),   \
  HOS_CELL(cam_z, z_dist, 0x54),   \
  HOS_CELL(cam_z, z_dist, 0x55),   \
  HOS_CELL(cam_z, z_dist, 0x56),   \
  HOS_CELL(cam_z, z_dist, 0x57),   \
  HOS_CELL(cam_z, z_dist, 0x58),   \
  HOS_CELL(cam_z, z_dist, 0x59),   \
  HOS_CELL(cam_z, z_dist, 0x5A),   \
  HOS_CELL(cam_z, z_dist, 0x5B),   \
  HOS_CELL(cam_z, z_dist, 0x5C),   \
  HOS_CELL(cam_z, z_dist, 0x5D),   \
  HOS_CELL(cam_z, z_dist, 0x5E),   \
  HOS_CELL(cam_z, z_dist, 0x5F),   \
  HOS_CELL(cam_z, z_dist, 0x60),   \
  HOS_CELL(cam_z, z_dist, 0x61),   \
  HOS_CELL(cam_z, z_dist, 0x62),   \
  HOS_CELL(cam_z, z_dist, 0x63),   \
  HOS_CELL(cam_z, z_dist, 0x64),   \
  HOS_CELL(cam_z, z_dist, 0x65),   \
  HOS_CELL(cam_z, z_dist, 0x66),   \
  HOS_CELL(cam_z, z_dist, 0x67),   \
  HOS_CELL(cam_z, z_dist, 0x68),   \
  HOS_CELL(cam_z, z_dist, 0x69),   \
  HOS_CELL(cam_z, z_dist, 0x6A),   \
  HOS_CELL(cam_z, z_dist, 0x6B),   \
  HOS_CELL(cam_z, z_dist, 0x6C),   \
  HOS_CELL(cam_z, z_dist, 0x6D),   \
  HOS_CELL(cam_z, z_dist, 0x6E),   \
  HOS_CELL(cam_z, z_dist, 0x6F),   \
  HOS_CELL(cam_z, z_dist, 0x70),   \
  HOS_CELL(cam_z, z_dist, 0x71),   \
  HOS_CELL(cam_z, z_dist, 0x72),   \
  HOS_CELL(cam_z, z_dist, 0x73),   \
  HOS_CELL(cam_z, z_dist, 0x74),   \
  HOS_CELL(cam_z, z_dist, 0x75),   \
  HOS_CELL(cam_z, z_dist, 0x76),   \
  HOS_CELL(cam_z, z_dist, 0x77),   \
  HOS_CELL(cam_z, z_dist, 0x78),   \
  HOS_CELL(cam_z, z_dist, 0x79),   \
  HOS_CELL(cam_z, z_dist, 0x7A),   \
  HOS_CELL(cam_z, z_dist, 0x7B),   \
  HOS_CELL(cam_z, z_dist, 0x7C),   \
  HOS_CELL(cam_z, z_dist, 0x7D),   \
  HOS_CELL(cam_z, z_dist, 0x7E),   \
  HOS_CELL(cam_z, z_dist, 0x7F),   \
  HOS_CELL(cam_z, z_dist, 0x80),   \
  HOS_CELL(cam_z, z_dist, 0x81),   \
  HOS_CELL(cam_z, z_dist, 0x82),   \
  HOS_CELL(cam_z, z_dist, 0x83),   \
  HOS_CELL(cam_z, z_dist, 0x84),   \
  HOS_CELL(cam_z, z_dist, 0x85),   \
  HOS_CELL(cam_z, z_dist, 0x86),   \
  HOS_CELL(cam_z, z_dist, 0x87),   \
  HOS_CELL(cam_z, z_dist, 0x88),   \
  HOS_CELL(cam_z, z_dist, 0x89),   \
  HOS_CELL(cam_z, z_dist, 0x8A),   \
  HOS_CELL(cam_z, z_dist, 0x8B),   \
  HOS_CELL(cam_z, z_dist, 0x8C),   \
  HOS_CELL(cam_z, z_dist, 0x8D),   \
  HOS_CELL(cam_z, z_dist, 0x8E),   \
  HOS_CELL(cam_z, z_dist, 0x8F),   \
  HOS_CELL(cam_z, z_dist, 0x90),   \
  HOS_CELL(cam_z, z_dist, 0x91),   \
  HOS_CELL(cam_z, z_dist, 0x92),   \
  HOS_CELL(cam_z, z_dist, 0x93),   \
  HOS_CELL(cam_z, z_dist, 0x94),   \
  HOS_CELL(cam_z, z_dist, 0x95),   \
  HOS_CELL(cam_z, z_dist, 0x96),   \
  HOS_CELL(cam_z, z_dist, 0x97),   \
  HOS_CELL(cam_z, z_dist, 0x98),   \
  HOS_CELL(cam_z, z_dist, 0x99),   \
  HOS_CELL(cam_z, z_dist, 0x9A),   \
  HOS_CELL(cam_z, z_dist, 0x9B),   \
  HOS_CELL(cam_z, z_dist, 0x9C),   \
  HOS_CELL(cam_z, z_dist, 0x9D),   \
  HOS_CELL(cam_z, z_dist, 0x9E),   \
  HOS_CELL(cam_z, z_dist, 0x9F),   \
  HOS_CELL(cam_z, z_dist, 0xA0),   \
  HOS_CELL(cam_z, z_dist, 0xA1),   \
  HOS_CELL(cam_z, z_dist, 0xA2),   \
  HOS_CELL(cam_z, z_dist, 0xA3),   \
  HOS_CELL(cam_z, z_dist, 0xA4),   \
  HOS_CELL(cam_z, z_dist, 0xA5),   \
  HOS_CELL(cam_z, z_dist, 0xA6),   \
  HOS_CELL(cam_z, z_dist, 0xA7),   \
  HOS_CELL(cam_z, z_dist, 0xA8),   \
  HOS_CELL(cam_z, z_dist, 0xA9),   \
  HOS_CELL(cam_z, z_dist, 0xAA),   \
  HOS_CELL(cam_z, z_dist, 0xAB),   \
  HOS_CELL(cam_z, z_dist, 0xAC),   \
  HOS_CELL(cam_z, z_dist, 0xAD),   \
  HOS_CELL(cam_z, z_dist, 0xAE),   \
  HOS_CELL(cam_z, z_dist, 0xAF),   \
  HOS_CELL(cam_z, z_dist, 0xB0),   \
  HOS_CELL(cam_z, z_dist, 0xB1),   \
  HOS_CELL(cam_z, z_dist, 0xB2),   \
  HOS_CELL(cam_z, z_dist, 0xB3),   \
  HOS_CELL(cam_z, z_dist, 0xB4),   \
  HOS_CELL(cam_z, z_dist, 0xB5),   \
  HOS_CELL(cam_z, z_dist, 0xB6),   \
  HOS_CELL(cam_z, z_dist, 0xB7),   \
  HOS_CELL(cam_z, z_dist, 0xB8),   \
  HOS_CELL(cam_z, z_dist, 0xB9),   \
  HOS_CELL(cam_z, z_dist, 0xBA),   \
  HOS_CELL(cam_z, z_dist, 0xBB),   \
  HOS_CELL(cam_z, z_dist, 0xBC),   \
  HOS_CELL(cam_z, z_dist, 0xBD),   \
  HOS_CELL(cam_z, z_dist, 0xBE),   \
  HOS_CELL(cam_z, z_dist, 0xBF),   \
  HOS_CELL(cam_z, z_dist, 0xC0),   \
  HOS_CELL(cam_z, z_dist, 0xC1),   \
  HOS_CELL(cam_z, z_dist, 0xC2),   \
  HOS_CELL(cam_z, z_dist, 0xC3),   \
  HOS_CELL(cam_z, z_dist, 0xC4),   \
  HOS_CELL(cam_z, z_dist, 0xC5),   \
  HOS_CELL(cam_z, z_dist, 0xC6),   \
  HOS_CELL(cam_z, z_dist, 0xC7),   \
  HOS_CELL(cam_z, z_dist, 0xC8),   \
  HOS_CELL(cam_z, z_dist, 0xC9),   \
  HOS_CELL(cam_z, z_dist, 0xCA),   \
  HOS_CELL(cam_z, z_dist, 0xCB),   \
  HOS_CELL(cam_z, z_dist, 0xCC),   \
  HOS_CELL(cam_z, z_dist, 0xCD),   \
  HOS_CELL(cam_z, z_dist, 0xCE),   \
  HOS_CELL(cam_z, z_dist, 0xCF),   \
  HOS_CELL(cam_z, z_dist, 0xD0),   \
  HOS_CELL(cam_z, z_dist, 0xD1),   \
  HOS_CELL(cam_z, z_dist, 0xD2),   \
  HOS_CELL(cam_z, z_dist, 0xD3),   \
  HOS_CELL(cam_z, z_dist, 0xD4),   \
  HOS_CELL(cam_z, z_dist, 0xD5),   \
  HOS_CELL(cam_z, z_dist, 0xD6),   \
  HOS_CELL(cam_z, z_dist, 0xD7),   \
  HOS_CELL(cam_z, z_dist, 0xD8),   \
  HOS_CELL(cam_z, z_dist, 0xD9),   \
  HOS_CELL(cam_z, z_dist, 0xDA),   \
  HOS_CELL(cam_z, z_dist, 0xDB),   \
  HOS_CELL(cam_z, z_dist, 0xDC),   \
  HOS_CELL(cam_z, z_dist, 0xDD),   \
  HOS_CELL(cam_z, z_dist, 0xDE),   \
  HOS_CELL(cam_z, z_dist, 0xDF),   \
  HOS_CELL(cam_z, z_dist, 0xE0),   \
  HOS_CELL(cam_z, z_dist, 0xE1),   \
  HOS_CELL(cam_z, z_dist, 0xE2),   \
  HOS_CELL(cam_z, z_dist, 0xE3),   \
  HOS_CELL(cam_z, z_dist, 0xE4),   \
  HOS_CELL(cam_z, z_dist, 0xE5),   \
  HOS_CELL(cam_z, z_dist, 0xE6),   \
  HOS_CELL(cam_z, z_dist, 0xE7),   \
  HOS_CELL(cam_z, z_dist, 0xE8),   \
  HOS_CELL(cam_z, z_dist, 0xE9),   \
  HOS_CELL(cam_z, z_dist, 0xEA),   \
  HOS_CELL(cam_z, z_dist, 0xEB),   \
  HOS_CELL(cam_z, z_dist, 0xEC),   \
  HOS_CELL(cam_z, z_dist, 0xED),   \
  HOS_CELL(cam_z, z_dist, 0xEE),   \
  HOS_CELL(cam_z, z_dist, 0xEF),   \
  HOS_CELL(cam_z, z_dist, 0xF0),   \
  HOS_CELL(cam_z, z_dist, 0xF1),   \
  HOS_CELL(cam_z, z_dist, 0xF2),   \
  HOS_CELL(cam_z, z_dist, 0xF3),   \
  HOS_CELL(cam_z, z_dist, 0xF4),   \
  HOS_CELL(cam_z, z_dist, 0xF5),   \
  HOS_CELL(cam_z, z_dist, 0xF6),   \
  HOS_CELL(cam_z, z_dist, 0xF7),   \
  HOS_CELL(cam_z, z_dist, 0xF8),   \
  HOS_CELL(cam_z, z_dist, 0xF9),   \
  HOS_CELL(cam_z, z_dist, 0xFA),   \
  HOS_CELL(cam_z, z_dist, 0xFB),   \
  HOS_CELL(cam_z, z_dist, 0xFC),   \
  HOS_CELL(cam_z, z_dist, 0xFD),   \
  HOS_CELL(cam_z, z_dist, 0xFE),   \
  HOS_CELL(cam_z, z_dist, 0xFF)}

#define HOS_TABLE(cam_z) {\
  HOS_ROW(cam_z, 0x2),   \
  HOS_ROW(cam_z, 0x2),   \
  HOS_ROW(cam_z, 0x2),   \
  HOS_ROW(cam_z, 0x3),   \
  HOS_ROW(cam_z, 0x4),   \
  HOS_ROW(cam_z, 0x5),   \
  HOS_ROW(cam_z, 0x6),   \
  HOS_ROW(cam_z, 0x7),   \
  HOS_ROW(cam_z, 0x8),   \
  HOS_ROW(cam_z, 0x9),   \
  HOS_ROW(cam_z, 0xA),   \
  HOS_ROW(cam_z, 0xB),   \
  HOS_ROW(cam_z, 0xC),   \
  HOS_ROW(cam_z, 0xD),   \
  HOS_ROW(cam_z, 0xE),   \
  HOS_ROW(cam_z, 0xF),   \
  HOS_ROW(cam_z, 0x10),   \
  HOS_ROW(cam_z, 0x11),   \
  HOS_ROW(cam_z, 0x12),   \
  HOS_ROW(cam_z, 0x13),   \
  HOS_ROW(cam_z, 0x14),   \
  HOS_ROW(cam_z, 0x15),   \
  HOS_ROW(cam_z, 0x16),   \
  HOS_ROW(cam_z, 0x17),   \
  HOS_ROW(cam_z, 0x18),   \
  HOS_ROW(cam_z, 0x19),   \
  HOS_ROW(cam_z, 0x1A),   \
  HOS_ROW(cam_z, 0x1B),   \
  HOS_ROW(cam_z, 0x1C),   \
  HOS_ROW(cam_z, 0x1D),   \
  HOS_ROW(cam_z, 0x1E),   \
  HOS_ROW(cam_z, 0x1F),   \
  HOS_ROW(cam_z, 0x20),   \
  HOS_ROW(cam_z, 0x21),   \
  HOS_ROW(cam_z, 0x22),   \
  HOS_ROW(cam_z, 0x23),   \
  HOS_ROW(cam_z, 0x24),   \
  HOS_ROW(cam_z, 0x25),   \
  HOS_ROW(cam_z, 0x26),   \
  HOS_ROW(cam_z, 0x27),   \
  HOS_ROW(cam_z, 0x28),   \
  HOS_ROW(cam_z, 0x29),   \
  HOS_ROW(cam_z, 0x2A),   \
  HOS_ROW(cam_z, 0x2B),   \
  HOS_ROW(cam_z, 0x2C),   \
  HOS_ROW(cam_z, 0x2D),   \
  HOS_ROW(cam_z, 0x2E),   \
  HOS_ROW(cam_z, 0x2F),   \
  HOS_ROW(cam_z, 0x30),   \
  HOS_ROW(cam_z, 0x31),   \
  HOS_ROW(cam_z, 0x32),   \
  HOS_ROW(cam_z, 0x33),   \
  HOS_ROW(cam_z, 0x34),   \
  HOS_ROW(cam_z, 0x35),   \
  HOS_ROW(cam_z, 0x36),   \
  HOS_ROW(cam_z, 0x37),   \
  HOS_ROW(cam_z, 0x38),   \
  HOS_ROW(cam_z, 0x39),   \
  HOS_ROW(cam_z, 0x3A),   \
  HOS_ROW(cam_z, 0x3B),   \
  HOS_ROW(cam_z, 0x3C),   \
  HOS_ROW(cam_z, 0x3D),   \
  HOS_ROW(cam_z, 0x3E),   \
  HOS_ROW(cam_z, 0x3F),   \
  HOS_ROW(cam_z, 0x40),   \
  HOS_ROW(cam_z, 0x41),   \
  HOS_ROW(cam_z, 0x42),   \
  HOS_ROW(cam_z, 0x43),   \
  HOS_ROW(cam_z, 0x44),   \
  HOS_ROW(cam_z, 0x45),   \
  HOS_ROW(cam_z, 0x46),   \
  HOS_ROW(cam_z, 0x47),   \
  HOS_ROW(cam_z, 0x48),   \
  HOS_ROW(cam_z, 0x49),   \
  HOS_ROW(cam_z, 0x4A),   \
  HOS_ROW(cam_z, 0x4B),   \
  HOS_ROW(cam_z, 0x4C),   \
  HOS_ROW(cam_z, 0x4D),   \
  HOS_ROW(cam_z, 0x4E),   \
  HOS_ROW(cam_z, 0x4F),   \
  HOS_ROW(cam_z, 0x50),   \
  HOS_ROW(cam_z, 0x51),   \
  HOS_ROW(cam_z, 0x52),   \
  HOS_ROW(cam_z, 0x53),   \
  HOS_ROW(cam_z, 0x54),   \
  HOS_ROW(cam_z, 0x55),   \
  HOS_ROW(cam_z, 0x56),   \
  HOS_ROW(cam_z, 0x57),   \
  HOS_ROW(cam_z, 0x58),   \
  HOS_ROW(cam_z, 0x59),   \
  HOS_ROW(cam_z, 0x5A),   \
  HOS_ROW(cam_z, 0x5B),   \
  HOS_ROW(cam_z, 0x5C),   \
  HOS_ROW(cam_z, 0x5D),   \
  HOS_ROW(cam_z, 0x5E),   \
  HOS_ROW(cam_z, 0x5F),   \
  HOS_ROW(cam_z, 0x60),   \
  HOS_ROW(cam_z, 0x61),   \
  HOS_ROW(cam_z, 0x62),   \
  HOS_ROW(cam_z, 0x63),   \
  HOS_ROW(cam_z, 0x64),   \
  HOS_ROW(cam_z, 0x65),   \
  HOS_ROW(cam_z, 0x66),   \
  HOS_ROW(cam_z, 0x67),   \
  HOS_ROW(cam_z, 0x68),   \
  HOS_ROW(cam_z, 0x69),   \
  HOS_ROW(cam_z, 0x6A),   \
  HOS_ROW(cam_z, 0x6B),   \
  HOS_ROW(cam_z, 0x6C),   \
  HOS_ROW(cam_z, 0x6D),   \
  HOS_ROW(cam_z, 0x6E),   \
  HOS_ROW(cam_z, 0x6F),   \
  HOS_ROW(cam_z, 0x70),   \
  HOS_ROW(cam_z, 0x71),   \
  HOS_ROW(cam_z, 0x72),   \
  HOS_ROW(cam_z, 0x73),   \
  HOS_ROW(cam_z, 0x74),   \
  HOS_ROW(cam_z, 0x75),   \
  HOS_ROW(cam_z, 0x76),   \
  HOS_ROW(cam_z, 0x77),   \
  HOS_ROW(cam_z, 0x78),   \
  HOS_ROW(cam_z, 0x79),   \
  HOS_ROW(cam_z, 0x7A),   \
  HOS_ROW(cam_z, 0x7B),   \
  HOS_ROW(cam_z, 0x7C),   \
  HOS_ROW(cam_z, 0x7D),   \
  HOS_ROW(cam_z, 0x7E),   \
  HOS_ROW(cam_z, 0x7F),   \
  HOS_ROW(cam_z, 0x80),   \
  HOS_ROW(cam_z, 0x81),   \
  HOS_ROW(cam_z, 0x82),   \
  HOS_ROW(cam_z, 0x83),   \
  HOS_ROW(cam_z, 0x84),   \
  HOS_ROW(cam_z, 0x85),   \
  HOS_ROW(cam_z, 0x86),   \
  HOS_ROW(cam_z, 0x87),   \
  HOS_ROW(cam_z, 0x88),   \
  HOS_ROW(cam_z, 0x89),   \
  HOS_ROW(cam_z, 0x8A),   \
  HOS_ROW(cam_z, 0x8B),   \
  HOS_ROW(cam_z, 0x8C),   \
  HOS_ROW(cam_z, 0x8D),   \
  HOS_ROW(cam_z, 0x8E),   \
  HOS_ROW(cam_z, 0x8F),   \
  HOS_ROW(cam_z, 0x90),   \
  HOS_ROW(cam_z, 0x91),   \
  HOS_ROW(cam_z, 0x92),   \
  HOS_ROW(cam_z, 0x93),   \
  HOS_ROW(cam_z, 0x94),   \
  HOS_ROW(cam_z, 0x95),   \
  HOS_ROW(cam_z, 0x96),   \
  HOS_ROW(cam_z, 0x97),   \
  HOS_ROW(cam_z, 0x98),   \
  HOS_ROW(cam_z, 0x99),   \
  HOS_ROW(cam_z, 0x9A),   \
  HOS_ROW(cam_z, 0x9B),   \
  HOS_ROW(cam_z, 0x9C),   \
  HOS_ROW(cam_z, 0x9D),   \
  HOS_ROW(cam_z, 0x9E),   \
  HOS_ROW(cam_z, 0x9F),   \
  HOS_ROW(cam_z, 0xA0),   \
  HOS_ROW(cam_z, 0xA1),   \
  HOS_ROW(cam_z, 0xA2),   \
  HOS_ROW(cam_z, 0xA3),   \
  HOS_ROW(cam_z, 0xA4),   \
  HOS_ROW(cam_z, 0xA5),   \
  HOS_ROW(cam_z, 0xA6),   \
  HOS_ROW(cam_z, 0xA7),   \
  HOS_ROW(cam_z, 0xA8),   \
  HOS_ROW(cam_z, 0xA9),   \
  HOS_ROW(cam_z, 0xAA),   \
  HOS_ROW(cam_z, 0xAB),   \
  HOS_ROW(cam_z, 0xAC),   \
  HOS_ROW(cam_z, 0xAD),   \
  HOS_ROW(cam_z, 0xAE),   \
  HOS_ROW(cam_z, 0xAF),   \
  HOS_ROW(cam_z, 0xB0),   \
  HOS_ROW(cam_z, 0xB1),   \
  HOS_ROW(cam_z, 0xB2),   \
  HOS_ROW(cam_z, 0xB3),   \
  HOS_ROW(cam_z, 0xB4),   \
  HOS_ROW(cam_z, 0xB5),   \
  HOS_ROW(cam_z, 0xB6),   \
  HOS_ROW(cam_z, 0xB7),   \
  HOS_ROW(cam_z, 0xB8),   \
  HOS_ROW(cam_z, 0xB9),   \
  HOS_ROW(cam_z, 0xBA),   \
  HOS_ROW(cam_z, 0xBB),   \
  HOS_ROW(cam_z, 0xBC),   \
  HOS_ROW(cam_z, 0xBD),   \
  HOS_ROW(cam_z, 0xBE),   \
  HOS_ROW(cam_z, 0xBF),   \
  HOS_ROW(cam_z, 0xC0),   \
  HOS_ROW(cam_z, 0xC1),   \
  HOS_ROW(cam_z, 0xC2),   \
  HOS_ROW(cam_z, 0xC3),   \
  HOS_ROW(cam_z, 0xC4),   \
  HOS_ROW(cam_z, 0xC5),   \
  HOS_ROW(cam_z, 0xC6),   \
  HOS_ROW(cam_z, 0xC7),   \
  HOS_ROW(cam_z, 0xC8),   \
  HOS_ROW(cam_z, 0xC9),   \
  HOS_ROW(cam_z, 0xCA),   \
  HOS_ROW(cam_z, 0xCB),   \
  HOS_ROW(cam_z, 0xCC),   \
  HOS_ROW(cam_z, 0xCD),   \
  HOS_ROW(cam_z, 0xCE),   \
  HOS_ROW(cam_z, 0xCF),   \
  HOS_ROW(cam_z, 0xD0),   \
  HOS_ROW(cam_z, 0xD1),   \
  HOS_ROW(cam_z, 0xD2),   \
  HOS_ROW(cam_z, 0xD3),   \
  HOS_ROW(cam_z, 0xD4),   \
  HOS_ROW(cam_z, 0xD5),   \
  HOS_ROW(cam_z, 0xD6),   \
  HOS_ROW(cam_z, 0xD7),   \
  HOS_ROW(cam_z, 0xD8),   \
  HOS_ROW(cam_z, 0xD9),   \
  HOS_ROW(cam_z, 0xDA),   \
  HOS_ROW(cam_z, 0xDB),   \
  HOS_ROW(cam_z, 0xDC),   \
  HOS_ROW(cam_z, 0xDD),   \
  HOS_ROW(cam_z, 0xDE),   \
  HOS_ROW(cam_z, 0xDF),   \
  HOS_ROW(cam_z, 0xE0),   \
  HOS_ROW(cam_z, 0xE1),   \
  HOS_ROW(cam_z, 0xE2),   \
  HOS_ROW(cam_z, 0xE3),   \
  HOS_ROW(cam_z, 0xE4),   \
  HOS_ROW(cam_z, 0xE5),   \
  HOS_ROW(cam_z, 0xE6),   \
  HOS_ROW(cam_z, 0xE7),   \
  HOS_ROW(cam_z, 0xE8),   \
  HOS_ROW(cam_z, 0xE9),   \
  HOS_ROW(cam_z, 0xEA),   \
  HOS_ROW(cam_z, 0xEB),   \
  HOS_ROW(cam_z, 0xEC),   \
  HOS_ROW(cam_z, 0xED),   \
  HOS_ROW(cam_z, 0xEE),   \
  HOS_ROW(cam_z, 0xEF),   \
  HOS_ROW(cam_z, 0xF0),   \
  HOS_ROW(cam_z, 0xF1),   \
  HOS_ROW(cam_z, 0xF2),   \
  HOS_ROW(cam_z, 0xF3),   \
  HOS_ROW(cam_z, 0xF4),   \
  HOS_ROW(cam_z, 0xF5),   \
  HOS_ROW(cam_z, 0xF6),   \
  HOS_ROW(cam_z, 0xF7),   \
  HOS_ROW(cam_z, 0xF8),   \
  HOS_ROW(cam_z, 0xF9),   \
  HOS_ROW(cam_z, 0xFA),   \
  HOS_ROW(cam_z, 0xFB),   \
  HOS_ROW(cam_z, 0xFC),   \
  HOS_ROW(cam_z, 0xFD),   \
  HOS_ROW(cam_z, 0xFE),   \
  HOS_ROW(cam_z, 0xFF)    \
}

#endif