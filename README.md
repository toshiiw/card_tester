# Background

There seems to be "fake" memory cards that don't have advertised
amount of memory. It is theoretically possible to fool simple integrity
checks that write all-zeros or simple patterns.

# Idea

The script makes use of block encryption implemented in the kernel.
While the data are all-zeros on an encrypted device, they appear to be
completely random at the underlying device.

# Disclaimer

Use the standard caution of operating on disk devices.
Be careful with the device names, or you will lose your data.
