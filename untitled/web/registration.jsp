<%--
  Created by IntelliJ IDEA.
  User: ttang
  Date: 2020-06-05
  Time: 19:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="css/style1.css">
    <link rel="stylesheet" href="css/hdyz.css">
    <script src="jquery-3.4.1.js"></script>
</head>
<body>
<form action="registrationDo.jsp" class="login-form" style="width: 450px;height: 800px" enctype="multipart/form-data"
      method="post">
    <h1>注册</h1>
    <div style="margin-top:-20px;margin-left: 20px">
        <img id="show" src="img/User.png" style=" border-radius: 100px;width: 50px;">
        <input id="file" name="head" style="margin-left: 10px;" value="选择您的头像" type="file" onchange="c()"
               accept="image/jpg"/>
    </div>
    <hr style="border:#adadad solid 1px">
    <div class="txtb" style="margin-top: 20px">
        <input type="text" name="username"/>
        <span data-placeholder="Username"></span>
    </div>

    <div class="txtb">
        <input type="password" name="password"/>
        <span data-placeholder="Password"></span>
    </div>
    <div class="txtb">
        <input type="text" name="mailbox"/>
        <span data-placeholder="Mailbox"></span>
    </div>
    <div class="txtb">
        <input type="text" name="phone_num"/>
        <span data-placeholder="UerId"></span>
    </div>
    <div class="container " style="margin-bottom: 20px">
        <div id="captcha" style="position: relative"></div>
    </div>
    <%--<%if (f){--%>
    <%--}%>--%>
    <input type="button" id="tijiao" class="logbtu" value="提交">

</form>

<script type="text/javascript">
    $(function () {
        $(".txtb input").on("focus", function () {
            $(this).addClass("focus");
        });
    });
    $(function () {
        $(".txtb input").on("blur", function () {
            if ($(this).val() == "")
                $(this).removeClass("focus");
        });
    });

    function c() {
        var r = new FileReader();
        f = document.getElementById('file').files[0];
        r.readAsDataURL(f);
        r.onload = function (e) {
            document.getElementById('show').src = this.result;
        };

    }

    (function (window) {
        const l = 42, // 滑块边长
            r = 10, // 滑块半径
            w = 310, // canvas宽度
            h = 155, // canvas高度
            PI = Math.PI
        const L = l + r * 2 // 滑块实际边长
        function getRandomNumberByRange(start, end) {
            return Math.round(Math.random() * (end - start) + start)
        }

        function createCanvas(width, height) {
            const canvas = createElement('canvas')
            canvas.width = width
            canvas.height = height
            return canvas
        }

        function createImg(onload) {
            const img = createElement('img')
            img.crossOrigin = "Anonymous"
            img.onload = onload
            img.onerror = () => {
                img.src = getRandomImg()
            }
            img.src = getRandomImg()
            return img
        }

        function createElement(tagName) {
            return document.createElement(tagName)
        }

        function addClass(tag, className) {
            tag.classList.add(className)
        }

        function removeClass(tag, className) {
            tag.classList.remove(className)
        }

        function getRandomImg() {
            return 'https://picsum.photos/300/150/?image=' + getRandomNumberByRange(0, 100)
        }

        function draw(ctx, operation, x, y) {
            ctx.beginPath()
            ctx.moveTo(x, y)
            ctx.arc(x + l / 2, y - r + 2, r, 0.72 * PI, 2.26 * PI)
            ctx.lineTo(x + l, y)
            ctx.arc(x + l + r - 2, y + l / 2, r, 1.21 * PI, 2.78 * PI)
            ctx.lineTo(x + l, y + l)
            ctx.lineTo(x, y + l)
            ctx.arc(x + r - 2, y + l / 2, r + 0.4, 2.76 * PI, 1.24 * PI, true)
            ctx.lineTo(x, y)
            ctx.lineWidth = 2
            ctx.fillStyle = 'rgba(255, 255, 255, 0.7)'
            ctx.strokeStyle = 'rgba(255, 255, 255, 0.7)'
            ctx.stroke()
            ctx[operation]()
            ctx.globalCompositeOperation = 'overlay'

        }

        function sum(x, y) {
            return x + y
        }

        function square(x) {
            return x * x
        }

        class jigsaw {
            constructor(el, success, fail) {
                this.el = el
                this.success = success
                this.fail = fail
            }

            init() {
                this.initDOM()
                this.initImg()
                this.draw()
                this.bindEvents()
            }

            initDOM() {
                const canvas = createCanvas(w, h) // 画布
                const block = canvas.cloneNode(true) // 滑块
                const sliderContainer = createElement('div')
                const refreshIcon = createElement('div')
                const sliderMask = createElement('div')
                const slider = createElement('div')
                const sliderIcon = createElement('span')
                const text = createElement('span')
                block.className = 'block'
                sliderContainer.className = 'sliderContainer'
                refreshIcon.className = 'refreshIcon'
                sliderMask.className = 'sliderMask'
                slider.className = 'slider'
                sliderIcon.className = 'sliderIcon'
                text.innerHTML = '向右滑动滑块填充拼图'
                text.className = 'sliderText'
                const el = this.el
                el.appendChild(canvas)
                el.appendChild(refreshIcon)
                el.appendChild(block)
                slider.appendChild(sliderIcon)
                sliderMask.appendChild(slider)
                sliderContainer.appendChild(sliderMask)
                sliderContainer.appendChild(text)
                el.appendChild(sliderContainer)
                Object.assign(this, {
                    canvas,
                    block,
                    sliderContainer,
                    refreshIcon,
                    slider,
                    sliderMask,
                    sliderIcon,
                    text,
                    canvasCtx: canvas.getContext('2d'),
                    blockCtx: block.getContext('2d')
                })
            }

            initImg() {
                const img = createImg(() => {
                    this.canvasCtx.drawImage(img, 0, 0, w, h)
                    this.blockCtx.drawImage(img, 0, 0, w, h)
                    const y = this.y - r * 2 + 2
                    const ImageData = this.blockCtx.getImageData(this.x, y, L, L)
                    this.block.width = L
                    this.blockCtx.putImageData(ImageData, 0, y)
                })
                this.img = img
            }

            draw() {
                // 随机创建滑块的位置
                this.x = getRandomNumberByRange(L + 10, w - (L + 10))
                this.y = getRandomNumberByRange(10 + r * 2, h - (L + 10))
                draw(this.canvasCtx, 'fill', this.x, this.y)
                draw(this.blockCtx, 'clip', this.x, this.y)
            }

            clean() {
                this.canvasCtx.clearRect(0, 0, w, h)
                this.blockCtx.clearRect(0, 0, w, h)
                this.block.width = w
            }

            bindEvents() {
                this.el.onselectstart = () => false
                this.refreshIcon.onclick = () => {
                    this.reset()
                }
                let originX, originY, trail = [],
                    isMouseDown = false
                this.slider.addEventListener('mousedown', function (e) {
                    originX = e.x, originY = e.y
                    isMouseDown = true
                })
                document.addEventListener('mousemove', (e) => {
                    if (!isMouseDown) return false
                    const moveX = e.x - originX
                    const moveY = e.y - originY
                    if (moveX < 0 || moveX + 38 >= w) return false
                    this.slider.style.left = moveX + 'px'
                    var blockLeft = (w - 40 - 20) / (w - 40) * moveX
                    this.block.style.left = blockLeft + 'px'
                    addClass(this.sliderContainer, 'sliderContainer_active')
                    this.sliderMask.style.width = moveX + 'px'
                    trail.push(moveY)
                })
                document.addEventListener('mouseup', (e) => {
                    if (!isMouseDown) return false
                    isMouseDown = false
                    if (e.x == originX) return false
                    removeClass(this.sliderContainer, 'sliderContainer_active')
                    this.trail = trail
                    const {
                        spliced,
                        TuringTest
                    } = this.verify()
                    if (spliced) {
                        if (TuringTest) {
                            addClass(this.sliderContainer, 'sliderContainer_success')
                            this.success && this.success()
                        } else {
                            addClass(this.sliderContainer, 'sliderContainer_fail')
                            this.text.innerHTML = '再试一次'
                            this.reset()
                        }
                    } else {
                        alert("验证失败");
                        addClass(this.sliderContainer, 'sliderContainer_fail')
                        this.fail && this.fail();
                        //验证失败后，1秒后重新加载图片
                        setTimeout(() => {
                            this.reset()
                        }, 1000)
                    }
                })
            }

            verify() {
                const arr = this.trail // 拖动时y轴的移动距离
                const average = arr.reduce(sum) / arr.length // 平均值
                const deviations = arr.map(x => x - average) // 偏差数组
                const stddev = Math.sqrt(deviations.map(square).reduce(sum) / arr.length) // 标准差
                const left = parseInt(this.block.style.left)
                return {
                    spliced: Math.abs(left - this.x) < 10,
                    TuringTest: average !== stddev, // 只是简单的验证拖动轨迹，相等时一般为0，表示可能非人为操作
                }
            }

            reset() {
                this.sliderContainer.className = 'sliderContainer'
                this.slider.style.left = 0
                this.block.style.left = 0
                this.sliderMask.style.width = 0
                this.clean()
                this.img.src = getRandomImg()
                this.draw()
            }
        }

        window.jigsaw = {
            init: function (element, success, fail) {
                new jigsaw(element, success, fail).init()
            }
        }
    }(window))
    jigsaw.init(document.getElementById('captcha'), function () {
        alert("验证成功");
        $(".logbtu").replaceWith('<input type="submit" id="tijiao" class="logbtu" value="提交">');
    })

</script>
</body>
</html>
