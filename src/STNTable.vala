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

		public STNTable.from_file (FileReader reader)
		{
			read (reader);
		}

		public void read (FileReader reader)
		{
			uint16 Length = reader.read_bits_as_uint16 (16);

			int64 Position = reader.tell (); // Needed to seek

			reader.skip_bits (16);

			uint8 NumberOfPrimaryVideoStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryAudioStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryPGStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryIGStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryAudioStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryVideoStreams = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryPGStreams = reader.read_bits_as_uint8 (8);

			reader.skip_bits (40);

			PrimaryVideoStreamEntry = new StreamEntry[NumberOfPrimaryVideoStreams];
			PrimaryVideoStreamAttributes = new StreamAttributes[NumberOfPrimaryVideoStreams];

			for (int i = 0; i < NumberOfPrimaryVideoStreams; i += 1)
			{
				// StreamEntry
				PrimaryVideoStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				PrimaryVideoStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			PrimaryAudioStreamEntry = new StreamEntry[NumberOfPrimaryAudioStreams];
			PrimaryAudioStreamAttributes = new StreamAttributes[NumberOfPrimaryAudioStreams];

			for (int i = 0; i < NumberOfPrimaryAudioStreams; i += 1)
			{
				// StreamEntry
				PrimaryAudioStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				PrimaryAudioStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			PrimaryPGStreamEntry = new StreamEntry[NumberOfPrimaryPGStreams];
			PrimaryPGStreamAttributes = new StreamAttributes[NumberOfPrimaryPGStreams];

			for (int i = 0; i < NumberOfPrimaryPGStreams; i += 1)
			{
				// StreamEntry
				PrimaryPGStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				PrimaryPGStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			SecondaryPGStreamEntry = new StreamEntry[NumberOfSecondaryPGStreams];
			SecondaryPGStreamAttributes = new StreamAttributes[NumberOfSecondaryPGStreams];

			for (int i = 0; i < NumberOfSecondaryPGStreams; i += 1)
			{
				// StreamEntry
				SecondaryPGStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				SecondaryPGStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			PrimaryIGStreamEntry = new StreamEntry[NumberOfPrimaryIGStreams];
			PrimaryIGStreamAttributes = new StreamAttributes[NumberOfPrimaryIGStreams];

			for (int i = 0; i < NumberOfPrimaryIGStreams; i += 1)
			{
				// StreamEntry
				PrimaryIGStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				PrimaryIGStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			SecondaryAudioStreamEntry = new StreamEntry[NumberOfSecondaryAudioStreams];
			SecondaryAudioStreamAttributes = new StreamAttributes[NumberOfSecondaryAudioStreams];

			for (int i = 0; i < NumberOfSecondaryAudioStreams; i += 1)
			{
				// StreamEntry
				SecondaryAudioStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				SecondaryAudioStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			SecondaryVideoStreamEntry = new StreamEntry[NumberOfSecondaryVideoStreams];
			SecondaryVideoStreamAttributes = new StreamAttributes[NumberOfSecondaryVideoStreams];

			for (int i = 0; i < NumberOfSecondaryVideoStreams; i += 1)
			{
				// StreamEntry
				SecondaryVideoStreamEntry[i] = new StreamEntry.from_file (reader);

				// StreamAttributes
				SecondaryVideoStreamAttributes[i] = new StreamAttributes.from_file (reader);
			}

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

