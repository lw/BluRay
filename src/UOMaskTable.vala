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
	class UOMaskTable : Object
	{
		public uint8 MenuCall { get; set; }

		public uint8 TitleSearch { get; set; }

		public uint8 ChapterSearch { get; set; }

		public uint8 TimeSearch { get; set; }

		public uint8 SkipToNextPoint { get; set; }

		public uint8 SkipToPrevPoint { get; set; }

		public uint8 Stop { get; set; }

		public uint8 PauseOn { get; set; }

		public uint8 StillOff { get; set; }

		public uint8 ForwardPlay { get; set; }

		public uint8 BackwardPlay { get; set; }

		public uint8 Resume { get; set; }

		public uint8 MoveUpSelectedButton { get; set; }

		public uint8 MoveDownSelectedButton { get; set; }

		public uint8 MoveLeftSelectedButton { get; set; }

		public uint8 MoveRightSelectedButton { get; set; }

		public uint8 SelectButton { get; set; }

		public uint8 ActivateButton { get; set; }

		public uint8 SelectAndActivateButton { get; set; }

		public uint8 PrimaryAudioStreamNumberChange { get; set; }

		public uint8 AngleNumberChange { get; set; }

		public uint8 PopupOn { get; set; }

		public uint8 PopupOff { get; set; }

		public uint8 PGEnableDisable { get; set; }

		public uint8 PGStreamNumberChange { get; set; }

		public uint8 SecondaryVideoEnableDisable { get; set; }

		public uint8 SecondaryVideoStreamNumberChange { get; set; }

		public uint8 SecondaryAudioEnableDisable { get; set; }

		public uint8 SecondaryAudioStreamNumberChange { get; set; }

		public uint8 SecondaryPGStreamNumberChange { get; set; }

		public UOMaskTable.from_bit_input_stream (BitInputStream input_stream) throws ParseError
		{
			try
			{
				MenuCall = input_stream.read_bits_as_uint8 (1);
				TitleSearch = input_stream.read_bits_as_uint8 (1);
				ChapterSearch = input_stream.read_bits_as_uint8 (1);
				TimeSearch = input_stream.read_bits_as_uint8 (1);
				SkipToNextPoint = input_stream.read_bits_as_uint8 (1);
				SkipToPrevPoint = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (1);

				Stop = input_stream.read_bits_as_uint8 (1);
				PauseOn = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (1);

				StillOff = input_stream.read_bits_as_uint8 (1);
				ForwardPlay = input_stream.read_bits_as_uint8 (1);
				BackwardPlay = input_stream.read_bits_as_uint8 (1);
				Resume = input_stream.read_bits_as_uint8 (1);
				MoveUpSelectedButton = input_stream.read_bits_as_uint8 (1);
				MoveDownSelectedButton = input_stream.read_bits_as_uint8 (1);
				MoveLeftSelectedButton = input_stream.read_bits_as_uint8 (1);
				MoveRightSelectedButton = input_stream.read_bits_as_uint8 (1);
				SelectButton = input_stream.read_bits_as_uint8 (1);
				ActivateButton = input_stream.read_bits_as_uint8 (1);
				SelectAndActivateButton = input_stream.read_bits_as_uint8 (1);
				PrimaryAudioStreamNumberChange = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (1);

				AngleNumberChange = input_stream.read_bits_as_uint8 (1);
				PopupOn = input_stream.read_bits_as_uint8 (1);
				PopupOff = input_stream.read_bits_as_uint8 (1);
				PGEnableDisable = input_stream.read_bits_as_uint8 (1);
				PGStreamNumberChange = input_stream.read_bits_as_uint8 (1);
				SecondaryVideoEnableDisable = input_stream.read_bits_as_uint8 (1);
				SecondaryVideoStreamNumberChange = input_stream.read_bits_as_uint8 (1);
				SecondaryAudioEnableDisable = input_stream.read_bits_as_uint8 (1);
				SecondaryAudioStreamNumberChange = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (1);

				SecondaryPGStreamNumberChange = input_stream.read_bits_as_uint8 (1);

				input_stream.skip_bits (30);
			}
			catch (IOError e)
			{
				throw new ParseError.INPUT_ERROR ("Couldn't parse UOMaskTable.");
			}
		}

//		public void write (BitOutputStream output_stream)
//		{
//		}
	}
}

