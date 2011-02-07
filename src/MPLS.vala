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
	class MPLS : Object
	{
		public string TypeIndicator { get; set; default = "MPLS"; }

		public string TypeIndicator2 { get; set; default = "0200"; }

		public AppInfoPlayList AppInfoPlayList { get; set; default = new BluRay.AppInfoPlayList (); }

		public PlayList PlayList { get; set; default = new BluRay.PlayList (); }

		public PlayListMark PlayListMark { get; set; default = new BluRay.PlayListMark (); }

		public MPLS.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			TypeIndicator = reader.read_string (4);
			TypeIndicator2 = reader.read_string (4);

			uint32 PlayListStartAddress = reader.read_bits_as_uint32 (32);
			uint32 PlayListMarkStartAddress = reader.read_bits_as_uint32 (32);
			uint32 ExtensionDataStartAddress = reader.read_bits_as_uint32 (32);

			reader.skip_bits (160);

			// AppInfoPlayList
			AppInfoPlayList.read (reader);

			reader.seek (PlayListStartAddress);

			// PlayList
			PlayList.read (reader);

			reader.seek (PlayListMarkStartAddress);

			// PlayListMarks
			PlayListMark.read (reader);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

