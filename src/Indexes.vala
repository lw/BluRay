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
	class Indexes : Object
	{
		public Title FirstPlaybackTitle { get; set; }

		public Title TopMenuTitle { get; set; }

		public ArrayList<Title> Title { get; set; }

		public Indexes.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				// FirstPlaybackTitle
				FirstPlaybackTitle = new BluRay.Title.from_bit_input_stream (input_stream);

				// TopMenuTitle
				TopMenuTitle = new BluRay.Title.from_bit_input_stream (input_stream);

				uint16 NumberOfTitles = input_stream.read_bits_as_uint16 (16);

				Title = new ArrayList<Title> ();

				for (int i = 0; i < NumberOfTitles; i += 1)
				{
					// Title
					Title.add (new BluRay.Title.from_bit_input_stream (input_stream));
				}

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse Indexes.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

