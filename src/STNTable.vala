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
		public Stream[] PrimaryVideoStreamEntries { get; set; }

		public Stream[] PrimaryAudioStreamEntries { get; set; }

		public Stream[] PrimaryPGStreamEntries { get; set; }

		public Stream[] PrimaryIGStreamEntries { get; set; }

		public Stream[] SecondaryVideoStreamEntries { get; set; }

		public Stream[] SecondaryAudioStreamEntries { get; set; }

		public Stream[] SecondaryPGStreamEntries { get; set; }

		public void read (FileReader reader)
		{
			uint16 Length = reader.read_bits_as_uint16 (16);

			int64 Position = reader.tell (); // Needed to seek

			reader.skip_bits (16);

			uint8 NumberOfPrimaryVideoStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryAudioStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryPGStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfPrimaryIGStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryAudioStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryVideoStreamEntries = reader.read_bits_as_uint8 (8);
			uint8 NumberOfSecondaryPGStreamEntries = reader.read_bits_as_uint8 (8);

			reader.skip_bits (40);

			PrimaryVideoStreamEntries = new Stream[NumberOfPrimaryVideoStreamEntries];

			for (int i = 0; i < NumberOfPrimaryVideoStreamEntries; i += 1)
			{
				// Stream
				PrimaryVideoStreamEntries[i] = new Stream ();
				PrimaryVideoStreamEntries[i].read (reader);
			}

			PrimaryAudioStreamEntries = new Stream[NumberOfPrimaryAudioStreamEntries];

			for (int i = 0; i < NumberOfPrimaryAudioStreamEntries; i += 1)
			{
				// Stream
				PrimaryAudioStreamEntries[i] = new Stream ();
				PrimaryAudioStreamEntries[i].read (reader);
			}

			PrimaryPGStreamEntries = new Stream[NumberOfPrimaryPGStreamEntries];

			for (int i = 0; i < NumberOfPrimaryPGStreamEntries; i += 1)
			{
				// Stream
				PrimaryPGStreamEntries[i] = new Stream ();
				PrimaryPGStreamEntries[i].read (reader);
			}

			SecondaryPGStreamEntries = new Stream[NumberOfSecondaryPGStreamEntries];

			for (int i = 0; i < NumberOfSecondaryPGStreamEntries; i += 1)
			{
				// Stream
				SecondaryPGStreamEntries[i] = new Stream ();
				SecondaryPGStreamEntries[i].read (reader);
			}

			PrimaryIGStreamEntries = new Stream[NumberOfPrimaryIGStreamEntries];

			for (int i = 0; i < NumberOfPrimaryIGStreamEntries; i += 1)
			{
				// Stream
				PrimaryIGStreamEntries[i] = new Stream ();
				PrimaryIGStreamEntries[i].read (reader);
			}

			SecondaryAudioStreamEntries = new Stream[NumberOfSecondaryAudioStreamEntries];

			for (int i = 0; i < NumberOfSecondaryAudioStreamEntries; i += 1)
			{
				// Stream
				SecondaryAudioStreamEntries[i] = new Stream ();
				SecondaryAudioStreamEntries[i].read (reader);
			}

			SecondaryVideoStreamEntries = new Stream[NumberOfSecondaryVideoStreamEntries];

			for (int i = 0; i < NumberOfSecondaryVideoStreamEntries; i += 1)
			{
				// Stream
				SecondaryVideoStreamEntries[i] = new Stream ();
				SecondaryVideoStreamEntries[i].read (reader);
			}

			reader.seek (Position + Length);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

