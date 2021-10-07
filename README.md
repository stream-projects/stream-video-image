# About
This Dockerfile configures the dependencies required to run headless chrome with GPU acceleration. It also installs the extra packages required to support puppeteer.

I've only been able to get it to work on Ubuntu 20.04 with the pinned version of Chrome (not Chromium, regular chrome has better codec support). This [Linux Uprising post](https://www.linuxuprising.com/2018/08/how-to-enable-hardware-accelerated.html) found the patched vdpau-va-driver required to get VA-API support working. Once running, chrome://gpu should return an output like so:

![Logo](https://res.cloudinary.com/stream-studio/image/upload/v1633597030/pbhr3d2bidp5gwldbwnn.png)

# Required Chrome Flags
Chrome must be started with these flags to be able to access the GPU. 

    [
            '--autoplay-policy=no-user-gesture-required', //convenience flag
            '--no-sandbox', //needed for docker
            '--use-gl=egl',
            '--enable-gpu-rasterization',
            '--enable-zero-copy',
            '--use-vulkan',
            '--ignore-gpu-blocklist',
            '--enable-features=VaapiVideoDecoder',
    ]

# Using the stream-video-image with puppeteer in NodeJS
This sample code exposes a /gpu endpoint which will fetch a screenshot of the chrome://gpu settings and return it. You can use it to verify that chrome is correctly configured to use the GPU. 

```js
    import  puppeteer, { Browser } from  'puppeteer';
    import  express  from  'express';
    const app = express();
    const port = 3000;
    app.get('/gpu', async (req, res) => {
	    try {
	       const browser = await puppeteer.launch({
		        executablePath: '/usr/bin/google-chrome',
		        headless: true,
		        args: [
		            '--autoplay-policy=no-user-gesture-required',
		            '--no-sandbox',
		            '--window-size=1280,720',
		            '--use-gl=egl',
		            '--enable-gpu-rasterization',
		            '--enable-zero-copy',
		            '--use-vulkan',
		            '--ignore-gpu-blocklist',
		            '--enable-features=VaapiVideoDecoder',
		            '--allow-insecure-localhost',
		        ],
		    });
	        const page = await browser.newPage();
	        await page.goto('chrome://gpu', {
	            timeout: 5000,
	        });
	        const image = await page.screenshot({ fullPage: true });
	        await browser.close();
	        res.set('Content-Type', 'image/png');
	        res.send(image);
	    } catch (error) {
	        console.log(error);
	        if (!res.headersSent) {
	            return res.sendStatus(500);
	        }
	    }
    });
    
    app.listen(port, () => {
	    console.log(`Sample app listening on ${port}`)
    });
```
    
# About us
We're a team on a mission to make it easier to go live from your browser. Check out our [in-browser livestreaming SDK here](https://www.notion.so/streamclub/Stream-Club-Cloud-c271d47f77c0497898df801471468fdf).
