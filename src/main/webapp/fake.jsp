<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Product Verification – Not Authentic</title>
    <style>
        :root {
            --bg: #0f0f12;
            --card: #17171c;
            --text: #e9eaee;
            --muted: #a5a7ae;
            --danger: #ff3b3b;
            --danger-weak: #ff5b5b;
            --border: #26262e;
            --success: #22c55e;
            --warning: #f59e0b;
        }

        * {
            box-sizing: border-box;
        }

        html,
        body {
            height: 100%;
        }

        body {
            margin: 0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
            background:
                radial-gradient(80rem 80rem at 10% -20%, #2a0a0a 0%, transparent 60%),
                radial-gradient(60rem 60rem at 110% 20%, #1a0e0e 0%, transparent 55%),
                var(--bg);
            color: var(--text);
            line-height: 1.55;
            padding: 24px;
        }

        .wrap {
            max-width: 760px;
            margin: 0 auto;
        }

        .card {
            background: linear-gradient(180deg, rgba(255, 60, 60, 0.05), transparent 35%), var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            padding: 22px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.35);
            backdrop-filter: blur(2px);
        }

        .badge {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 8px 12px;
            border-radius: 999px;
            background: rgba(255, 59, 59, 0.1);
            border: 1px solid rgba(255, 59, 59, 0.25);
            color: var(--danger);
            font-weight: 700;
            letter-spacing: .2px;
            text-transform: uppercase;
            font-size: .85rem;
        }

        .sirens {
            display: inline-flex;
            width: 22px;
            height: 22px;
            justify-content: center;
            align-items: center;
            background: rgba(255, 59, 59, 0.15);
            border-radius: 50%;
            animation: pulse 1.4s infinite ease-in-out;
        }

        @keyframes pulse {
            0% {
                box-shadow: 0 0 0 0 rgba(255, 59, 59, 0.35);
            }

            70% {
                box-shadow: 0 0 0 12px rgba(255, 59, 59, 0);
            }

            100% {
                box-shadow: 0 0 0 0 rgba(255, 59, 59, 0);
            }
        }

        @keyframes shake {

            0%,
            100% {
                transform: translateX(0);
            }

            20% {
                transform: translateX(-3px);
            }

            40% {
                transform: translateX(3px);
            }

            60% {
                transform: translateX(-2px);
            }

            80% {
                transform: translateX(2px);
            }
        }

        h1 {
            margin: 14px 0 8px;
            font-size: clamp(1.4rem, 2.5vw, 1.9rem);
            line-height: 1.2;
        }

        .sub {
            color: var(--muted);
            margin-bottom: 18px;
        }

        .alert {
            display: flex;
            gap: 12px;
            align-items: flex-start;
            background: rgba(255, 59, 59, 0.1);
            border: 1px solid rgba(255, 59, 59, 0.25);
            padding: 14px;
            border-radius: 12px;
            margin: 14px 0 18px;
        }

        .alert strong {
            color: var(--danger);
        }

        .alert .icon {
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 59, 59, 0.15);
            animation: shake 1.3s ease-in-out 0.2s 1;
        }




        .btn {
            appearance: none;
            border: none;
            cursor: pointer;
            border-radius: 12px;
            padding: 12px 16px;
            font-weight: 700;
            transition: transform .06s ease, box-shadow .2s ease, ;
            box-shadow: 0 6px 16px rgba(0, 0, 0, .25);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #111;
            background: linear-gradient(180deg, var(--danger-weak), #ff4444);
            color: #fff;
        }

        .btn:hover {
            transform: translateY(-1px);
        }



        .tips {
            margin-top: 18px;
            border-top: 1px solid var(--border);
            padding-top: 14px;
            color: var(--muted);
            font-size: .95rem;
        }

        .tips ul {
            margin: 8px 0 0 18px;
            padding: 0;
        }

        .tips li {
            margin: 6px 0;
        }

        .ribbon {
            text-align: center;
            margin-top: 16px;
            font-size: .9rem;
            color: var(--muted);
        }

        .ribbon .safe {
            color: var(--success);
            font-weight: 700;
        }

        .ribbon .warn {
            color: var(--warning);
            font-weight: 700;
        }

        /* Mobile tweaks */
        @media (max-width: 560px) {
            body {
                padding: 16px;
            }

            .card {
                padding: 18px;
            }


            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>

<body>
    <div class="wrap">
        <div class="card" role="alert" aria-live="polite">
            <span class="badge" aria-label="Verification result: Not authentic">
                <span class="sirens">🚨</span> Not Authentic
            </span>

            <h1>Warning: This product appears to be <span style="color:var(--danger)">FAKE</span>.</h1>
            <p class="sub">Our verification system could not match this code to a genuine item. Please do not use or
                resell this product.</p>

            <div class="alert">
                <div class="icon">❌</div>
                <div>
                    <strong>Do not proceed.</strong><br />
                    The code you entered failed authenticity checks. It may be a counterfeit or tampered item.
                </div>
            </div>


            <a href="tel:1111" class="btn secondary" id="btn-support">Contact Support</a>

        </div>

        <div class="tips">
            <strong>Safety Tips</strong>
            <ul>
                <li>Buy only from authorized retailers or the brand’s official store.</li>
                <li>Check packaging quality, spelling, and seals for tampering.</li>
                <li>Compare the price—if it’s too low to be true, it probably is.</li>
                <li>Keep your receipt and report the seller if suspicious.</li>
            </ul>
        </div>

        <div class="ribbon">
            Verified by <span class="safe">🛡️ AuthentiTrack</span> • If you believe this is a mistake, <a href="#"
                id="link-appeal" style="color:#93c5fd;text-decoration:underline;">submit an appeal</a>.
            <br /><span class="warn">Using counterfeit products can be unsafe.</span>
        </div>
    </div>
    </div>
</body>

</html></html>