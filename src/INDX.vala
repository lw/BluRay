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
	class INDX : Object
	{
		public string TypeIndicator { get; set; default = "MPLS"; }

		public string TypeIndicator2 { get; set; default = "0200"; }

		public AppInfoBDMV AppInfoBDMV { get; set; default = new BluRay.AppInfoBDMV (); }

		public Title FirstPlaybackTitle { get; set; default = new BluRay.Title (); }

		public Title TopMenuTitle { get; set; default = new BluRay.Title (); }

		public Title[] Titles { get; set; }

		public void read (FileReader reader)
		{
			TypeIndicator = reader.read_string (4);
			TypeIndicator2 = reader.read_string (4);

			uint32 IndexesStartAddress = reader.read_bits_as_uint32 (32);
			uint32 ExtensionDataStartAddress = reader.read_bits_as_uint32 (32);

			reader.skip_bits (192);

			// AppInfoPlayList
			AppInfoBDMV.read (reader);

			// Indexes
			reader.seek (IndexesStartAddress);
			{
				uint32 Length = reader.read_bits_as_uint32 (32);

				int64 Position = reader.tell (); // Needed to seek

				FirstPlaybackTitle.read (reader);
				TopMenuTitle.read (reader);

				uint16 NumberOfTitles = reader.read_bits_as_uint16 (16);

				Titles = new Title[NumberOfTitles];

				for (int i = 0; i < NumberOfTitles; i += 1)
				{
					// Title
					Titles[i] = new Title ();
					Titles[i].read (reader);
				}

				reader.seek (Position + Length);
			}
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

