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
	class PlayList : Object
	{
		public ArrayList<PlayItem> PlayItem { get; set; }

		public ArrayList<SubPath> SubPath { get; set; }

		public PlayList.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (16);

				uint16 NumberOfPlayItems = input_stream.read_bits_as_uint16 (16);
				uint16 NumberOfSubPaths = input_stream.read_bits_as_uint16 (16);

				PlayItem = new ArrayList<PlayItem> ();

				for (int i = 0; i < NumberOfPlayItems; i += 1)
				{
					// PlayItem
					PlayItem.add (new BluRay.PlayItem.from_bit_input_stream (input_stream));

				}

				SubPath = new ArrayList<SubPath> ();

				for (int i = 0; i < NumberOfSubPaths; i += 1)
				{
					// SubPath
					SubPath.add (new BluRay.SubPath.from_bit_input_stream (input_stream));
				}

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse PlayList.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

