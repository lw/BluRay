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
	class Indexes : Object
	{
		public Title FirstPlaybackTitle { get; set; default = new BluRay.Title (); }

		public Title TopMenuTitle { get; set; default = new BluRay.Title (); }

		public Title[] Title { get; set; }

		public Indexes.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			uint32 Length = reader.read_bits_as_uint32 (32);

			int64 Position = reader.tell (); // Needed to seek

			// FirstPlaybackTitle
			FirstPlaybackTitle.read (reader);

			// TopMenuTitle
			TopMenuTitle.read (reader);

			uint16 NumberOfTitles = reader.read_bits_as_uint16 (16);

			Title = new Title[NumberOfTitles];

			for (int i = 0; i < NumberOfTitles; i += 1)
			{
				// Title
				Title[i] = new BluRay.Title.from_file (reader);
			}

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

