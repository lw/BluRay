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
	class Title : Object
	{
		public uint8 ObjectType { get; set; }

		public uint16 AccessType { get; set; }

		public uint32 PlaybackType { get; set; }

		public uint8[] ObjectData { get; set; }

		public void read (FileReader reader)
		{
			ObjectType = reader.read_bits_as_uint8 (2);
			AccessType = reader.read_bits_as_uint8 (2);

			reader.skip_bits (28);

			PlaybackType = reader.read_bits_as_uint16 (2);

			reader.skip_bits (14);

			ObjectData = reader.read_bytes (6);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

