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
	class PlayList : Object
	{
		public PlayItem[] PlayItem { get; set; }

		public SubPath[] SubPath { get; set; }

		public PlayList.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			uint32 Length = reader.read_bits_as_uint32 (32);

			int64 Position = reader.tell (); // Needed to seek

			reader.skip_bits (16);

			uint16 NumberOfPlayItems = reader.read_bits_as_uint16 (16);
			uint16 NumberOfSubPaths = reader.read_bits_as_uint16 (16);

			PlayItem = new PlayItem[NumberOfPlayItems];

			for (int i = 0; i < NumberOfPlayItems; i += 1)
			{
				// PlayItem
				PlayItem[i] = new BluRay.PlayItem.from_file (reader);

			}

			SubPath = new SubPath[NumberOfSubPaths];

			for (int i = 0; i < NumberOfSubPaths; i += 1)
			{
				// SubPath
				SubPath[i] = new BluRay.SubPath.from_file (reader);
			}

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

