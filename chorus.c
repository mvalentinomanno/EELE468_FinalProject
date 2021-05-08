/* SPDX-License-Identifier: GPL-2.0 or MIT */
#include <linux/module.h>
#include <linux/platform_device.h>
#include <linux/mod_devicetable.h>
#include <linux/types.h>
#include <linux/io.h>
#include <linux/mutex.h>
#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/uaccess.h>
#include "fp_conversions.h"

#define LEFT_ENABLE_OFFSET 0x0
#define LEFT_DELAY_OFFSET 0x4
#define LEFT_DELAY_OFFSET2 0x8
#define LEFT_GAIN_OFFSET 0xc
#define LEFT_VOLUME_OFFSET 0x10

#define RIGHT_ENABLE_OFFSET 0x14
#define RIGHT_DELAY_OFFSET 0x18
#define RIGHT_DELAY_OFFSET2 0x1c
#define RIGHT_GAIN_OFFSET 0x20
#define RIGHT_VOLUME_OFFSET 0x24

#define GAIN_FBITS 15
#define GAIN_IS_SIGNED 0

#define SPAN 0x28

/**
 * struct chorus_dev - Private chorus device struct.
 * @miscdev: miscdevice used to create a char device for the chorus
 * @base_addr: Base address of the chorus component
 * @lock: mutex used to prevent concurrent writes to the chorus
 *
 * An chorus_dev struct gets created for each chorus in the system.
 */
struct chorus_dev {
	struct miscdevice miscdev;
	void __iomem *base_addr;
	struct mutex lock;
};


static ssize_t left_enable_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	bool left_enable;

	// Get the private chorus data out of the dev struct
	struct chorus_dev *priv = dev_get_drvdata(dev);

	left_enable = ioread32(priv->base_addr + LEFT_ENABLE_OFFSET);

	return scnprintf(buf, PAGE_SIZE, "%u\n", left_enable);
}

/**
 * left_enable_store() - Store the left_enable value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t left_enable_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	bool left_enable;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a bool
	ret = kstrtobool(buf, &left_enable);
	if (ret < 0) {
		// kstrtobool returned an error
		return ret;
	}

	iowrite32(left_enable, priv->base_addr + LEFT_ENABLE_OFFSET);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}

/**
 * right_enable_show() - Return the right_enable value to user-space via sysfs.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that gets returned to the chorus value to user-space.
 *
 * Return: The number of bytes read.
 */
static ssize_t right_enable_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	bool right_enable;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	right_enable = ioread32(priv->base_addr + RIGHT_ENABLE_OFFSET);

	return scnprintf(buf, PAGE_SIZE, "%u\n", right_enable);
}

/**
 * right_enable_store() - Store the right_enable value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t right_enable_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	bool right_enable;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a bool
	ret = kstrtobool(buf, &right_enable);
	if (ret < 0) {
		// kstrtobool returned an error
		return ret;
	}

	iowrite32(right_enable, priv->base_addr + RIGHT_ENABLE_OFFSET);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}

/**
 * left_delay_show() - Return the left delay value to user-space via sysfs.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that gets returned to the chorus value to user-space.
 *
 * Return: The number of bytes read.
 */
static ssize_t left_delay_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u16 left_delay;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	left_delay = ioread32(priv->base_addr + LEFT_DELAY_OFFSET);

	return scnprintf(buf, PAGE_SIZE, "%u\n", left_delay);
}

/**
 * left_delay_store() - Store the left_delay value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t left_delay_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u16 left_delay;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a u16
	ret = kstrtou16(buf, 0, &left_delay);
	if (ret < 0) {
		// kstrtou16 returned an error
		return ret;
	}

	iowrite32(left_delay, priv->base_addr + LEFT_DELAY_OFFSET);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}

/**
 * right_delay_show() - Return the right_delay value to user-space via sysfs.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that gets returned to the chorus value to user-space.
 *
 * Return: The number of bytes read.
 */
static ssize_t right_delay_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u16 right_delay;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	right_delay = ioread32(priv->base_addr + RIGHT_DELAY_OFFSET);

	return scnprintf(buf, PAGE_SIZE, "%u\n", right_delay);
}

/**
 * right_delay_store() - Store the right_delay value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t right_delay_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u16 right_delay;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a u16
	ret = kstrtou16(buf, 0, &right_delay);
	if (ret < 0) {
		// kstrtou16 returned an error
		return ret;
	}

	iowrite32(right_delay, priv->base_addr + RIGHT_DELAY_OFFSET);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}


static ssize_t left_delay2_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u16 left_delay2;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	left_delay2 = ioread32(priv->base_addr + LEFT_DELAY_OFFSET2);

	return scnprintf(buf, PAGE_SIZE, "%u\n", left_delay2);
}

static ssize_t left_delay2_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u16 left_delay2;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a u16
	ret = kstrtou16(buf, 0, &left_delay2);
	if (ret < 0) {
		// kstrtou16 returned an error
		return ret;
	}

	iowrite32(left_delay2, priv->base_addr + LEFT_DELAY_OFFSET2);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}


static ssize_t right_delay2_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u16 right_delay2;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	right_delay2 = ioread32(priv->base_addr + RIGHT_DELAY_OFFSET2);

	return scnprintf(buf, PAGE_SIZE, "%u\n", right_delay2);
}


static ssize_t right_delay2_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u16 right_delay2;
	int ret;
	struct chorus_dev *priv = dev_get_drvdata(dev);

	// Parse the string we received as a u16
	ret = kstrtou16(buf, 0, &right_delay2);
	if (ret < 0) {
		// kstrtou16 returned an error
		return ret;
	}

	iowrite32(right_delay2, priv->base_addr + RIGHT_DELAY_OFFSET2);

	// Write was succesful, so we return the number of bytes we wrote.
	return size;
}





/**
 * left_gain_show() - Return the left gain value to user-space via sysfs.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that gets returned to the chorus value to user-space.
 *
 * Return: The number of bytes read.
 */
static ssize_t left_gain_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u32 left_gain;
	struct chorus_dev *priv = dev_get_drvdata(dev);
	left_gain = ioread32(priv->base_addr + LEFT_GAIN_OFFSET);
	return fp_to_str(buf, left_gain, GAIN_FBITS, GAIN_IS_SIGNED);


// todo: Add left_gain_show() code
// Use  1.) dev_get_drvdata()
//      2.) ioread32()
//      3.) fp_to_str()
}

/**
 * left_gain_store() - Store the left_gain value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t left_gain_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{

	u32 left_gain;

	struct chorus_dev *priv = dev_get_drvdata(dev);
	left_gain = str_to_fp(buf, GAIN_FBITS, GAIN_IS_SIGNED, size);
	iowrite32(left_gain, priv->base_addr + LEFT_GAIN_OFFSET);
	return size;


// toodo: Add left_gain_store() code
// Use  1.) dev_get_drvdata()
//      2.) str_to_fp()
//      3.) iowrite32()
}

/**
 * right_gain_show() - Return the right_gain value to user-space via sysfs.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that gets returned to the chorus value to user-space.
 *
 * Return: The number of bytes read.
 */
static ssize_t right_gain_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u32 right_gain;
	struct chorus_dev *priv = dev_get_drvdata(dev);
	right_gain = ioread32(priv->base_addr + RIGHT_GAIN_OFFSET);
	return fp_to_str(buf, right_gain, GAIN_FBITS, GAIN_IS_SIGNED);


// toodo: Add right_gain_show() code
// Use  1.) dev_get_drvdata()
//      2.) ioread32()
//      3.) fp_to_str()
}

/**
 * right_gain_store() - Store the right_gain value.
 * @dev: Device structure for the chorus. This device struct is embedded in
 *       the chorus's platform device struct.
 * @attr: Unused.
 * @buf: Buffer that contains the chorus value being written.
 * @size: The number of bytes being written.
 *
 * Return: The number of bytes stored.
 */
static ssize_t right_gain_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u32 right_gain;

	struct chorus_dev *priv = dev_get_drvdata(dev);
	right_gain = str_to_fp(buf, GAIN_FBITS, GAIN_IS_SIGNED, size);
	iowrite32(right_gain, priv->base_addr + RIGHT_GAIN_OFFSET);

	return size;

// toodo: Add right_gain_store() code
// Use  1.) dev_get_drvdata()
//      2.) str_to_fp()
//      3.) iowrite32()
}


static ssize_t left_volume_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u32 left_volume;
	struct chorus_dev *priv = dev_get_drvdata(dev);
	left_volume = ioread32(priv->base_addr + LEFT_VOLUME_OFFSET);
	return fp_to_str(buf, left_volume, GAIN_FBITS, GAIN_IS_SIGNED);


}

static ssize_t left_volume_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{

	u32 left_volume;

	struct chorus_dev *priv = dev_get_drvdata(dev);
	left_volume = str_to_fp(buf, GAIN_FBITS, GAIN_IS_SIGNED, size);
	iowrite32(left_volume, priv->base_addr + LEFT_VOLUME_OFFSET);
	return size;


}

static ssize_t right_volume_show(struct device *dev,
	struct device_attribute *attr, char *buf)
{
	u32 right_volume;
	struct chorus_dev *priv = dev_get_drvdata(dev);
	right_volume = ioread32(priv->base_addr + RIGHT_VOLUME_OFFSET);
	return fp_to_str(buf, right_volume, GAIN_FBITS, GAIN_IS_SIGNED);

}

static ssize_t right_volume_store(struct device *dev,
	struct device_attribute *attr, const char *buf, size_t size)
{
	u32 right_volume;

	struct chorus_dev *priv = dev_get_drvdata(dev);
	right_volume = str_to_fp(buf, GAIN_FBITS, GAIN_IS_SIGNED, size);
	iowrite32(right_volume, priv->base_addr + RIGHT_VOLUME_OFFSET);

	return size;
}

// Define sysfs attributes
static DEVICE_ATTR_RW(left_enable);
static DEVICE_ATTR_RW(right_enable);
// toodo: define left gain attribute 
// toodo: define right gain attribute
static DEVICE_ATTR_RW(left_gain);
static DEVICE_ATTR_RW(right_gain);
static DEVICE_ATTR_RW(left_delay);
static DEVICE_ATTR_RW(right_delay);
static DEVICE_ATTR_RW(left_delay2);
static DEVICE_ATTR_RW(right_delay2);
static DEVICE_ATTR_RW(left_volume);
static DEVICE_ATTR_RW(right_volume);

// Create an atribute group so the device core can export the attributes for us.
static struct attribute *chorus_attrs[] = {
	&dev_attr_left_enable.attr,
	&dev_attr_right_enable.attr,
	&dev_attr_left_gain.attr,
	&dev_attr_right_gain.attr,
	&dev_attr_left_delay.attr,
	&dev_attr_right_delay.attr,
	&dev_attr_left_delay2.attr,
	&dev_attr_right_delay2.attr,
	&dev_attr_left_volume.attr,
	&dev_attr_right_volume.attr,
	NULL,
};
ATTRIBUTE_GROUPS(chorus);

/**
 * chorus_read() - Read method for the chorus char device
 * @file: Pointer to the char device file struct.
 * @buf: User-space buffer to read the value into.
 * @count: The number of bytes being requested.
 * @offset: The byte offset in the file being read from.
 *
 * Return: On success, the number of bytes written is returned and the
 * offset @offset is advanced by this number. On error, a negative error
 * value is returned.
 */
static ssize_t chorus_read(struct file *file, char __user *buf,
	size_t count, loff_t *offset)
{
	size_t ret;
	u32 val;

	loff_t pos = *offset;

	/*
	 * Get the device's private data from the file struct's private_data
	 * field. The private_data field is equal to the miscdev field in the
	 * chorus_dev struct. container_of returns the chorus_dev struct
	 * that contains the miscdev in private_data.
	 */
	struct chorus_dev *priv = container_of(file->private_data,
	                                     struct chorus_dev,
					     miscdev);


	// Check file offset to make sure we are reading to a valid location.
	if (pos < 0) {
		// We can't read from a negative file position.
		return -EINVAL;
	}
	if (pos >= SPAN) {
		// We can't read from a position past the end of our device.
		return 0;
	}
	if ((pos % 0x4) != 0) {
		/*
		 * Prevent unaligned access. Even though the hardware
		 * technically supports unaligned access, we want to
		 * ensure that we only access 32-bit-aligned addresses
		 * because our registers are 32-bit-aligned.
		 */
		pr_warn("chorus_read: unaligned access\n");
		return -EFAULT;
	}

	// If the user didn't request any bytes, don't return any bytes :)
	if (count == 0) {
		return 0;
	}

	// Read the value at offset pos.
	val = ioread32(priv->base_addr + pos);

	ret = copy_to_user(buf, &val, sizeof(val));
	if (ret == sizeof(val)) {
		// Nothing was copied to the user.
		pr_warn("chorus_read: nothing copied\n");
		return -EFAULT;
	}

	// Increment the file offset by the number of bytes we read.
	*offset = pos + sizeof(val);

	return sizeof(val);
}

/**
 * chorus_write() - Write method for the chorus char device
 * @file: Pointer to the char device file struct.
 * @buf: User-space buffer to read the value from.
 * @count: The number of bytes being written.
 * @offset: The byte offset in the file being written to.
 *
 * Return: On success, the number of bytes written is returned and the
 * offset @offset is advanced by this number. On error, a negative error
 * value is returned.
 */
static ssize_t chorus_write(struct file *file, const char __user *buf,
	size_t count, loff_t *offset)
{
	size_t ret;
	u32 val;

	loff_t pos = *offset;

	/*
	 * Get the device's private data from the file struct's private_data
	 * field. The private_data field is equal to the miscdev field in the
	 * chorus_dev struct. container_of returns the chorus_dev struct
	 * that contains the miscdev in private_data.
	 */
	struct chorus_dev *priv = container_of(file->private_data,
	                                     struct chorus_dev,
					     miscdev);


	// Check file offset to make sure we are writing to a valid location.
	if (pos < 0) {
		// We can't write to a negative file position.
		return -EINVAL;
	}
	if (pos >= SPAN) {
		// We can't write to a position past the end of our device.
		return 0;
	}
	if ((pos % 0x4) != 0) {
		/*
		 * Prevent unaligned access. Even though the hardware
		 * technically supports unaligned access, we want to
		 * ensure that we only access 32-bit-aligned addresses
		 * because our registers are 32-bit-aligned.
		 */
		pr_warn("chorus_write: unaligned access\n");
		return -EFAULT;
	}

	// If the user didn't request to write anything, return 0.
	if (count == 0) {
		return 0;
	}

	mutex_lock(&priv->lock);

	ret = copy_from_user(&val, buf, sizeof(val));
	if (ret == sizeof(val)) {
		// Nothing was copied from the user.
		pr_warn("chorus_write: nothing copied\n");
		ret = -EFAULT;
		goto unlock;
	}

	// Write the value we were given at the address offset given by pos.
	iowrite32(val, priv->base_addr + pos);

	// Increment the file offset by the number of bytes we wrote.
	*offset = pos + sizeof(val);

	// Return the number of bytes we wrote.
	ret = sizeof(val);

unlock:
	mutex_unlock(&priv->lock);
	return ret;
}

/**
 * chorus_fops - File operations supported by the chorus driver
 * @owner: The chorus driver owns the file operations; this ensures that the
 *         driver can't be removed while the character device is still in use.
 * @read: The read function.
 * @write: The write function.
 * @llseek: We use the kernel's default_llseek() function; this allows users to
 *          change what position they are writing/reading to/from.
 */
static const struct file_operations chorus_fops = {
	.owner = THIS_MODULE,
	.read = chorus_read,
	.write = chorus_write,
	.llseek = default_llseek,
};

/**
 * chorus_probe() - Initialize device when a match is found
 * @pdev: Platform device structure associated with our chorus device;
 *        pdev is automatically created by the driver core based upon our
 *        chorus device tree node.
 *
 * When a device that is compatible with this chorus driver is found, the
 * driver's probe function is called. This probe function gets called by the
 * kernel when an chorus device is found in the device tree.
 */
static int chorus_probe(struct platform_device *pdev)
{
	struct chorus_dev *priv;
	int ret;

	/*
	 * Allocate kernel memory for the chorus device and set it to 0.
	 * GFP_KERNEL specifies that we are allocating normal kernel RAM;
	 * see the kmalloc documentation for more info. The allocated memory
	 * is automatically freed when the device is removed.
	 */
	priv = devm_kzalloc(&pdev->dev, sizeof(struct chorus_dev), GFP_KERNEL);
	if (!priv) {
		pr_err("Failed to allocate memory\n");
		return -ENOMEM;
	}

	/*
	 * Request and remap the device's memory region. Requesting the region
	 * make sure nobody else can use that memory. The memory is remapped
	 * into the kernel's virtual address space becuase we don't have access
	 * to physical memory locations.
	 */
	priv->base_addr = devm_platform_ioremap_resource(pdev, 0);
	if (IS_ERR(priv->base_addr)) {
		pr_err("Failed to request/remap platform device resource\n");
		return PTR_ERR(priv->base_addr);
	}

	// Initialize the misc device parameters
	priv->miscdev.minor = MISC_DYNAMIC_MINOR;
	priv->miscdev.name = "chorus";
	priv->miscdev.fops = &chorus_fops;
	priv->miscdev.parent = &pdev->dev;
	priv->miscdev.groups = chorus_groups;

	// Register the misc device; this creates a char dev at /dev/chorus
	ret = misc_register(&priv->miscdev);
	if (ret) {
		pr_err("Failed to register misc device");
		return ret;
	}

	// Attach the chorus's private data to the platform device's struct.
	platform_set_drvdata(pdev, priv);

	pr_info("chorus_probe successful\n");

	return 0;
}

/**
 * chorus_remove() - Remove an chorus device.
 * @pdev: Platform device structure associated with our chorus device.
 *
 * This function is called when an chorus devicee is removed or
 * the driver is removed.
 */
static int chorus_remove(struct platform_device *pdev)
{
	// Get the chorus's private data from the platform device.
	struct chorus_dev *priv = platform_get_drvdata(pdev);

	// Deregister the misc device and remove the /dev/chorus file.
	misc_deregister(&priv->miscdev);

	pr_info("chorus_remove successful\n");

	return 0;
}

/*
 * Define the compatible property used for matching devices to this driver,
 * then add our device id structure to the kernel's device table. For a device
 * to be matched with this driver, its device tree node must use the same
 * compatible string as defined here.
 */
static const struct of_device_id chorus_of_match[] = {
	{ .compatible = "Valentino-Manno,chorus", },
    // toodo: Add compatible string with your lastname
	{ }
};
MODULE_DEVICE_TABLE(of, chorus_of_match);

/**
 * struct chorus_driver - Platform driver struct for the chorus driver
 * @probe: Function that's called when a device is found
 * @remove: Function that's called when a device is removed
 * @driver.owner: Which module owns this driver
 * @driver.name: Name of the chorus driver
 * @driver.of_match_table: Device tree match table
 * @driver.dev_groups: chorus sysfs attribute group; this
 *                     allows the driver core to create the
 *                     attribute(s) without race conditions.
 */
static struct platform_driver chorus_driver = {
	.probe = chorus_probe,
	.remove = chorus_remove,
	.driver = {
		.owner = THIS_MODULE,
		.name = "chorus",
		.of_match_table = chorus_of_match,
		.dev_groups = chorus_groups,
	},
};

/*
 * We don't need to do anything special in module init/exit.
 * This macro automatically handles module init/exit.
 */
module_platform_driver(chorus_driver);

MODULE_LICENSE("Dual MIT/GPL");
MODULE_AUTHOR("Michael Valentino-Manno");
// todo: Add MODULE_AUTHOR("with your name");
MODULE_DESCRIPTION("chorus driver");
MODULE_VERSION("1.0");
