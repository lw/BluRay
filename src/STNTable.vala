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
	class STNTable : Object
	{
		public StreamEntry[] PrimaryVideoStreamEntry { get; set; }

		public StreamAttributes[] PrimaryVideoStreamAttributes { get; set; }

		public StreamEntry[] PrimaryAudioStreamEntry { get; set; }

		public StreamAttributes[] PrimaryAudioStreamAttributes { get; set; }

		public StreamEntry[] PrimaryPGStreamEntry { get; set; }

		public StreamAttributes[] PrimaryPGStreamAttributes { get; set; }

		public StreamEntry[] PrimaryIGStreamEntry { get; set; }

		public StreamAttributes[] PrimaryIGStreamAttributes { get; set; }

		public StreamEntry[] SecondaryVideoStreamEntry { get; set; }

		public StreamAttributes[] SecondaryVideoStreamAttributes { get; set; }

		public StreamEntry[] SecondaryAudioStreamEntry { get; set; }

		public StreamAttributes[] SecondaryAudioStreamAttributes { get; set; }

		public StreamEntry[] SecondaryPGStreamEntry { get; set; }

		public StreamAttributes[] SecondaryPGStreamAttributes { get; set; }

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

				PrimaryVideoStreamEntry = new StreamEntry[NumberOfPrimaryVideoStreams];
				PrimaryVideoStreamAttributes = new StreamAttributes[NumberOfPrimaryVideoStreams];

				for (int i = 0; i < NumberOfPrimaryVideoStreams; i += 1)
				{
					// StreamEntry
					PrimaryVideoStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					PrimaryVideoStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				PrimaryAudioStreamEntry = new StreamEntry[NumberOfPrimaryAudioStreams];
				PrimaryAudioStreamAttributes = new StreamAttributes[NumberOfPrimaryAudioStreams];

				for (int i = 0; i < NumberOfPrimaryAudioStreams; i += 1)
				{
					// StreamEntry
					PrimaryAudioStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					PrimaryAudioStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				PrimaryPGStreamEntry = new StreamEntry[NumberOfPrimaryPGStreams];
				PrimaryPGStreamAttributes = new StreamAttributes[NumberOfPrimaryPGStreams];

				for (int i = 0; i < NumberOfPrimaryPGStreams; i += 1)
				{
					// StreamEntry
					PrimaryPGStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					PrimaryPGStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				SecondaryPGStreamEntry = new StreamEntry[NumberOfSecondaryPGStreams];
				SecondaryPGStreamAttributes = new StreamAttributes[NumberOfSecondaryPGStreams];

				for (int i = 0; i < NumberOfSecondaryPGStreams; i += 1)
				{
					// StreamEntry
					SecondaryPGStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					SecondaryPGStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				PrimaryIGStreamEntry = new StreamEntry[NumberOfPrimaryIGStreams];
				PrimaryIGStreamAttributes = new StreamAttributes[NumberOfPrimaryIGStreams];

				for (int i = 0; i < NumberOfPrimaryIGStreams; i += 1)
				{
					// StreamEntry
					PrimaryIGStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					PrimaryIGStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				SecondaryAudioStreamEntry = new StreamEntry[NumberOfSecondaryAudioStreams];
				SecondaryAudioStreamAttributes = new StreamAttributes[NumberOfSecondaryAudioStreams];

				for (int i = 0; i < NumberOfSecondaryAudioStreams; i += 1)
				{
					// StreamEntry
					SecondaryAudioStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					SecondaryAudioStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
				}

				SecondaryVideoStreamEntry = new StreamEntry[NumberOfSecondaryVideoStreams];
				SecondaryVideoStreamAttributes = new StreamAttributes[NumberOfSecondaryVideoStreams];

				for (int i = 0; i < NumberOfSecondaryVideoStreams; i += 1)
				{
					// StreamEntry
					SecondaryVideoStreamEntry[i] = new StreamEntry.from_bit_input_stream (input_stream);

					// StreamAttributes
					SecondaryVideoStreamAttributes[i] = new StreamAttributes.from_bit_input_stream (input_stream);
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

