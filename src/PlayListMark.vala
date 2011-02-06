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
	class PlayListMark : Object
	{
		public uint8 MarkType { get; set; }

		public uint16 RefToPlayItemID { get; set; }

		public uint32 MarkTimeStamp { get; set; }

		public uint16 EntryESPID { get; set; }

		public uint32 Duration { get; set; }

		public void read (FileReader reader)
		{
			MarkType = reader.read_bits_as_uint8 (8);
			RefToPlayItemID = reader.read_bits_as_uint16 (16);
			MarkTimeStamp = reader.read_bits_as_uint32 (32);
			EntryESPID = reader.read_bits_as_uint16 (16);
			Duration = reader.read_bits_as_uint32 (32);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

