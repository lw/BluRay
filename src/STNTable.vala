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
	class STNTable : Object
	{
		public ArrayList<StreamEntry> PrimaryVideoStreamEntry { get; set; }

		public ArrayList<StreamAttributes> PrimaryVideoStreamAttributes { get; set; }

		public ArrayList<StreamEntry> PrimaryAudioStreamEntry { get; set; }

		public ArrayList<StreamAttributes> PrimaryAudioStreamAttributes { get; set; }

		public ArrayList<StreamEntry> PrimaryPGStreamEntry { get; set; }

		public ArrayList<StreamAttributes> PrimaryPGStreamAttributes { get; set; }

		public ArrayList<StreamEntry> PrimaryIGStreamEntry { get; set; }

		public ArrayList<StreamAttributes> PrimaryIGStreamAttributes { get; set; }

		public ArrayList<StreamEntry> SecondaryVideoStreamEntry { get; set; }

		public ArrayList<StreamAttributes> SecondaryVideoStreamAttributes { get; set; }

		public ArrayList<StreamEntry> SecondaryAudioStreamEntry { get; set; }

		public ArrayList<StreamAttributes> SecondaryAudioStreamAttributes { get; set; }

		public ArrayList<StreamEntry> SecondaryPGStreamEntry { get; set; }

		public ArrayList<StreamAttributes> SecondaryPGStreamAttributes { get; set; }

		public STNTable.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				uint16 Length = input_stream.read_bits_as_uint16 (16);

				int64 Position = input_stream.tell (); // Needed to seek

				input_stream.skip_bits (16);

				uint8 NumberOfPrimaryVideoStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfPrimaryAudioStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfPrimaryPGStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfPrimaryIGStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfSecondaryAudioStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfSecondaryVideoStreams = input_stream.read_bits_as_uint8 (8);
				uint8 NumberOfSecondaryPGStreams = input_stream.read_bits_as_uint8 (8);

				input_stream.skip_bits (40);

				PrimaryVideoStreamEntry = new ArrayList<StreamEntry> ();
				PrimaryVideoStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfPrimaryVideoStreams; i += 1)
				{
					// StreamEntry
					PrimaryVideoStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					PrimaryVideoStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				PrimaryAudioStreamEntry = new ArrayList<StreamEntry> ();
				PrimaryAudioStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfPrimaryAudioStreams; i += 1)
				{
					// StreamEntry
					PrimaryAudioStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					PrimaryAudioStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				PrimaryPGStreamEntry = new ArrayList<StreamEntry> ();
				PrimaryPGStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfPrimaryPGStreams; i += 1)
				{
					// StreamEntry
					PrimaryPGStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					PrimaryPGStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				SecondaryPGStreamEntry = new ArrayList<StreamEntry> ();
				SecondaryPGStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfSecondaryPGStreams; i += 1)
				{
					// StreamEntry
					SecondaryPGStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					SecondaryPGStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				PrimaryIGStreamEntry = new ArrayList<StreamEntry> ();
				PrimaryIGStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfPrimaryIGStreams; i += 1)
				{
					// StreamEntry
					PrimaryIGStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					PrimaryIGStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				SecondaryAudioStreamEntry = new ArrayList<StreamEntry> ();
				SecondaryAudioStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfSecondaryAudioStreams; i += 1)
				{
					// StreamEntry
					SecondaryAudioStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					SecondaryAudioStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				SecondaryVideoStreamEntry = new ArrayList<StreamEntry> ();
				SecondaryVideoStreamAttributes = new ArrayList<StreamAttributes> ();

				for (int i = 0; i < NumberOfSecondaryVideoStreams; i += 1)
				{
					// StreamEntry
					SecondaryVideoStreamEntry.add (new StreamEntry.from_bit_input_stream (input_stream));

					// StreamAttributes
					SecondaryVideoStreamAttributes.add (new StreamAttributes.from_bit_input_stream (input_stream));
				}

				input_stream.seek (Position + Length);
			}
			catch (ParseError e)
			{
				throw e;
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse STNTable.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

