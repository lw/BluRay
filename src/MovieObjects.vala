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

using Gee;

namespace BluRay
{
	class MovieObjects : Object
	{
		public ArrayList<uint8> ResumeIntentionFlag { get; set; }

		public ArrayList<uint8> MenuCallMask { get; set; }

		public ArrayList<uint8> TitleSearchMask { get; set; }

		public ArrayList<ArrayList<NavigationCommand>> NavigationCommand { get; set; }

		public MovieObjects.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (32);

				uint16 NumberOfMovieObjects = input_stream.read_bits_as_uint16 (16);

				ResumeIntentionFlag = new ArrayList<uint8> ();
				MenuCallMask = new ArrayList<uint8> ();
				TitleSearchMask = new ArrayList<uint8> ();
				NavigationCommand = new ArrayList<ArrayList<NavigationCommand>> ();

				for (int i = 0; i < NumberOfMovieObjects; i += 1)
				{
					ResumeIntentionFlag.add (input_stream.read_bits_as_uint8 (1));
					MenuCallMask.add (input_stream.read_bits_as_uint8 (1));
					TitleSearchMask.add (input_stream.read_bits_as_uint8 (1));

					input_stream.skip_bits (13);

					uint16 NumberOfNavigationCommands = input_stream.read_bits_as_uint16 (16);

					NavigationCommand.add (new ArrayList<NavigationCommand> ());

					for (int j = 0; j < NumberOfNavigationCommands; j += 1)
					{
						// NavigationCommand
						NavigationCommand[i].add (new BluRay.NavigationCommand.from_bit_input_stream (input_stream));
					}
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse MovieObjects.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

