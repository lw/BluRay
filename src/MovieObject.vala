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
	class MovieObject : Object
	{
		public uint8 ResumeIntentionFlag { get; set; }

		public uint8 MenuCallMask { get; set; }

		public uint8 TitleSearchMask { get; set; }

		public NavigationCommand[] NavigationCommands { get; set; }

		public void read (FileReader reader)
		{
			ResumeIntentionFlag = reader.read_bits_as_uint8 (1);
			MenuCallMask = reader.read_bits_as_uint8 (1);
			TitleSearchMask = reader.read_bits_as_uint8 (1);

			uint16 NumberOfNavigationCommands = reader.read_bits_as_uint16 (16);

			NavigationCommands = new NavigationCommand[NumberOfNavigationCommands];

			for (int i = 0; i < NumberOfNavigationCommands; i += 1)
			{
				// NavigationCommand
				NavigationCommands[i] = new NavigationCommand ();
				NavigationCommands[i].read (reader);
			}
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

