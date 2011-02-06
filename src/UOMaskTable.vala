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

		public void read (FileReader reader)
		{
			MenuCall = reader.read_bits_as_uint8 (1);
			TitleSearch = reader.read_bits_as_uint8 (1);
			ChapterSearch = reader.read_bits_as_uint8 (1);
			TimeSearch = reader.read_bits_as_uint8 (1);
			SkipToNextPoint = reader.read_bits_as_uint8 (1);
			SkipToPrevPoint = reader.read_bits_as_uint8 (1);

			reader.skip_bits (1);

			Stop = reader.read_bits_as_uint8 (1);
			PauseOn = reader.read_bits_as_uint8 (1);

			reader.skip_bits (1);

			StillOff = reader.read_bits_as_uint8 (1);
			ForwardPlay = reader.read_bits_as_uint8 (1);
			BackwardPlay = reader.read_bits_as_uint8 (1);
			Resume = reader.read_bits_as_uint8 (1);
			MoveUpSelectedButton = reader.read_bits_as_uint8 (1);
			MoveDownSelectedButton = reader.read_bits_as_uint8 (1);
			MoveLeftSelectedButton = reader.read_bits_as_uint8 (1);
			MoveRightSelectedButton = reader.read_bits_as_uint8 (1);
			SelectButton = reader.read_bits_as_uint8 (1);
			ActivateButton = reader.read_bits_as_uint8 (1);
			SelectAndActivateButton = reader.read_bits_as_uint8 (1);
			PrimaryAudioStreamNumberChange = reader.read_bits_as_uint8 (1);

			reader.skip_bits (1);

			AngleNumberChange = reader.read_bits_as_uint8 (1);
			PopupOn = reader.read_bits_as_uint8 (1);
			PopupOff = reader.read_bits_as_uint8 (1);
			PGEnableDisable = reader.read_bits_as_uint8 (1);
			PGStreamNumberChange = reader.read_bits_as_uint8 (1);
			SecondaryVideoEnableDisable = reader.read_bits_as_uint8 (1);
			SecondaryVideoStreamNumberChange = reader.read_bits_as_uint8 (1);
			SecondaryAudioEnableDisable = reader.read_bits_as_uint8 (1);
			SecondaryAudioStreamNumberChange = reader.read_bits_as_uint8 (1);

			reader.skip_bits (1);

			SecondaryPGStreamNumberChange = reader.read_bits_as_uint8 (1);

			reader.skip_bits (30);
		}

		public void write (FileOutputStream stream)
		{
		}
	}
}

