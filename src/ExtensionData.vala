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
	class ExtensionData : Object
	{
		public ArrayList<uint16> ExtDataType { get; set; }

		public ArrayList<uint16> ExtDataVersion { get; set; }

		public ArrayList<string> ExtDataEntry { get; set; }

		public ExtensionData.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint32 Length = input_stream.read_bits_as_uint32 (32);

				int64 Position = input_stream.tell (); // Needed to seek

				if (Length != 0)
				{
					uint32 DataBlockStartAddress = input_stream.read_bits_as_uint32 (32);

					input_stream.skip_bits (24);

					uint8 NumberOfExtDataEntries = input_stream.read_bits_as_uint8 (8);

					ExtDataType = new ArrayList<uint16> ();
					ExtDataVersion = new ArrayList<uint16> ();

					ArrayList<uint32> ExtDataStartAddress = new ArrayList<uint32> ();
					ArrayList<uint32> ExtDataLength = new ArrayList<uint32> ();

					for (int i = 0; i < NumberOfExtDataEntries; i += 1)
					{
						ExtDataType.add (input_stream.read_bits_as_uint16 (16));
						ExtDataVersion.add (input_stream.read_bits_as_uint16 (16));
						ExtDataStartAddress.add (input_stream.read_bits_as_uint32 (32));
						ExtDataLength.add (input_stream.read_bits_as_uint32 (32));
					}

					input_stream.seek (DataBlockStartAddress);

					ExtDataEntry = new ArrayList<string> ();

					for (int i = 0; i < NumberOfExtDataEntries; i += 1)
					{
						input_stream.seek (ExtDataStartAddress[i]);

						ExtDataEntry.add (input_stream.read_string (ExtDataLength[i]));
					}
				}

				input_stream.seek (Position + Length);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse ExtensionData.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

