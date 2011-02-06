/*
 * BluRay - a simple sample implementation of Blu-ray Disc specifications
 * Copyright (C) 2011  Luca Wehrstedt

 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

namespace BluRay
{
	class AppInfoPlayList : Object
	{
		public uint8 PlaybackType { get; set; }

		public uint16 PlaybackCount { get; set; }

		public UOMaskTable UOMaskTable { get; set; default = new BluRay.UOMaskTable (); }

		public uint8 RandomAccessFlag { get; set; }

		public uint8 AudioMixFlag { get; set; }

		public uint8 LosslessBypassFlag { get; set; }

		public void read (FileReader reader)
		{
			uint32 Length = reader.read_bits_as_uint32 (32);

			int64 Position = reader.tell (); // Needed to seek

			reader.skip_bits (8);

			PlaybackType = reader.read_bits_as_uint8 (8);

			switch (PlaybackType)
			{
				case 0x01:
					reader.skip_bits (16);
					break;
				case 0x02:
					PlaybackCount = reader.read_bits_as_uint16 (16);
					break;
				case 0x03:
					PlaybackCount = reader.read_bits_as_uint16 (16);
					break;
			}

			// UOMaskTable
			UOMaskTable.read (reader);

			RandomAccessFlag = reader.read_bits_as_uint8 (1);
			AudioMixFlag = reader.read_bits_as_uint8 (1);
			LosslessBypassFlag = reader.read_bits_as_uint8 (1);
			reader.skip_bits (13);

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

