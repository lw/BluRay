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
	class MOBJ : Object
	{
		public string TypeIndicator { get; set; default = "MOBJ"; }

		public string TypeIndicator2 { get; set; default = "0200"; }

		public MovieObjects MovieObjects { get; set; default = new BluRay.MovieObjects (); }

		public MOBJ.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			TypeIndicator = reader.read_string (4);
			TypeIndicator2 = reader.read_string (4);

			uint32 ExtensionDataStartAddress = reader.read_bits_as_uint32 (32);

			reader.skip_bits (224);

			// MovieObjects
			MovieObjects.read (reader);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

