Name
	advmng - The AdvanceMNG compressor

Synopsis
	:advmng [-l, --list] [-z, --recompress]
	:[-x, --extract] [-a, --add RATE MNG_FILE PNG_FILES...]
	:[-0, --shrink-store] [-1, --shrink-fast] [-2, --shrink-normal]
	:[-3, --shrink-extra] [-4, --shrink-insane]
	:[-s, --scroll HxV] [-S, --scroll-square]
	:[-e, --expand] [-r, --reduce]
	:[-c, --lc] [-C, --vlc] [-f, --force] [-q, --quiet] [-v, --verbose]
	:[-h, --help] [-V, --version] FILES...

Description
	The main purpose of this utility is to recompress MNG
	files to get the smallest possible size.

	Please note that this utility is not able to read
	a generic file. It's granted to be able to read only
	the files generated by the AdvanceMAME emulator.

	To compress the files this utility uses the following
	strategies:

	* Remove all ancillary chunks.
	* Use the MNG Delta feature to compress video clips with
		only small changes between frames.
	* Use the MNG Move feature to compress video clips with
		a scrolling background (option -s).
	* Reduce the color depth to 8 bit (option -r).
	* Use the 7zip Deflate implementation.

Commands
	-l, --list FILES...
		List the content of the specified files.

	-z, --recompress FILES...
		Recompress the specified files. If the -1, -2, -3
		options are specified, it's used the smallest file
		choice from the previous compressed data and the
		new compression. If the -0 option is specified the
		file is always rewritten without any compression.

	-x, --extract FILES...
		Extract all the .png frames in the .mng clips.
		You can use the --shrink options to control the
		compression ratio of the .png files.

	-a, --add RATE MNG_FILE PNG_FILES...
		Compress all the .png files on the command line
		as a .mng file. All the .png files must have the
		same size and the same bit depth. You must also
		specify an integer frame rate to use in the
		.mng file.

Options
	-0, --shrink-store
		Disable the compression. The file is
		only stored and not compressed. The file is always
		rewritten also if it's bigger.

	-1, --shrink-fast
		Set the compression level to "fast".

	-2, --shrink-normal
		Set the compression level to "normal". This is the
		default level of compression.

	-3, --shrink-extra
		Set the compression level to "extra".

	-4, --shrink-insane
		Set the compression level to "insane". It's VERY
		SLOW.

	-s, --scroll HxV
		The "-s HxV" option specifies the size of the pattern
		(H width x V height) used to check for a
		scrolling background. The size is expressed in
		pixels and it must be bigger or equal than the
		scrolling speed of the background. For example
		take the game 1942 that scrolls vertically by 1
		pixel every frame. If you recorded with an interleave
		factor of 2 the vertical scrolling speed is
		1*2 = 2. In this case the minimum pattern is "-s 0x2".
		Generally you can use "-s 8x8" and use bigger
		values only for games scrolling faster. If the
		game scrolls only horizontally or vertically you can
		speed up a lot the compression with monodirectional
		patterns like "-s 16x0" or "-s 0x16".

	-S, --scroll-square N
		This option is like the option "-s NxN" but excludes
		big movement on both directions reducing the computation
		time. Specifically the check done is X+Y<=N.

	-r, --reduce
		Force the color reduction to 8 bit. The reduction is
		really done only if any frame have less than 256 colors.

	-e, --expand
		Force the color expansion to 24 bit.

	-c, --lc
		Force the use of the MNG LC (Low Complexity)
		specifications. It disables the delta compression.
		The file is always rewritten also if it's bigger.

	-C, --vlc
		Force the use of the MNG VLC (Very Low Complexity)
		specifications. It disables the delta compression
		and the precise timing. Warning! you may lose the
		correct timing information because the VLC format
		only supports integer frequency. The file is always
		rewritten also if it's bigger.

	-f, --force
		Force the use of the new file also if it's bigger.

	-q, --quiet
		Don't print the filenames.

	-v, --verbose
		Print more information on the compression process.

Examples
	A good tradeoff of recompression and time is the command :

		advmng -z -r -S 16 *.mng

	To create a .mng file from a series of .png files use the
	command :

		advmng -a 30 video.mng video*.png

	To extract all the images in a .mng file use the command :

		advmng -x video.mng

Copyright
	This file is Copyright (C) 2003 Andrea Mazzoleni, Filipe Estima

See Also
	advzip(1), advpng(1), advdef(1)
