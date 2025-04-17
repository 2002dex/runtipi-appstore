<<<<<<< HEAD
import { chromium } from "@playwright/test";
import { signUpUser } from "../fixtures/fixtures";

async function globalSetup() {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await signUpUser(page);
}

export default globalSetup;
=======
import { chromium } from "@playwright/test";
import { signUpUser } from "../fixtures/fixtures";

async function globalSetup() {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  await signUpUser(page);
}

export default globalSetup;
>>>>>>> 74093c8b193bea8aab6fff2202ad7ad0d2e7e85f
