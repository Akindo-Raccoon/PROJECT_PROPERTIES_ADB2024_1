import {
    Navbar,
    NavbarBrand,
    NavbarContent,
    NavbarItem,
    Link,
    Button,
    Image,
    Modal,
    ModalContent,
    ModalHeader,
    ModalBody,
    ModalFooter,
    useDisclosure,
    Checkbox,
    Input
} from "@nextui-org/react";
import "@/styles/nav.css";
import { MailIcon } from './atomic/MailIcon.tsx';
import { LockIcon } from './atomic/LockIcon.tsx';

const NavBar = () => {
    const { isOpen, onOpen, onOpenChange } = useDisclosure();
    return (
        <Navbar className=" bg-cyan-400" isBordered>
            <NavbarBrand className="text-left items-start justify-content: flex-start">
                <Link className="hover:cursor-pointer">
                    <Image
                        isZoomed
                        alt="Icon ViajesFeliz SA"
                        height={200}
                        src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3C3JQ7sGHL86rCwlchWB4pPEznVEnwZlXSQ&s"
                        width={230}
                        className="pl-0"
                    />
                </Link>
            </NavbarBrand>
            <NavbarContent className="text-right" justify="center">
                <NavbarItem isActive className="nav-item text-right hover:bg-sky-700">
                    <Link href="#">
                        Inicio
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#">
                        Propiedades
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#" >
                        Galeria
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#" >
                        Blog
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#" >
                        FAQs
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#" >
                        Contacto
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right">
                    <Link href="#" >
                        57 3203414663
                    </Link>
                </NavbarItem>
                <NavbarItem isActive className="nav-item text-right bg-lime-300" color="success">
                    <Button onPress={onOpen} href="#" variant="ghost" color="success">
                        Admin Sign Up
                    </Button>
                    <Modal isOpen={isOpen} onOpenChange={onOpenChange}>
                        <ModalContent>
                            {(onClose) => (
                                <>
                                    <ModalHeader className="flex flex-col gap-1">Admin Login</ModalHeader>
                                    <ModalBody>
                                        <Input
                                            autoFocus
                                            endContent={
                                                <MailIcon className="text-2xl text-default-400 pointer-events-none flex-shrink-0" />
                                            }
                                            label="Nickname"
                                            placeholder="Enter your Admin User"
                                            variant="bordered"
                                        />
                                        <Input
                                            endContent={
                                                <LockIcon className="text-2xl text-default-400 pointer-events-none flex-shrink-0" />
                                            }
                                            label="Password"
                                            placeholder="Enter your password"
                                            type="password"
                                            variant="bordered"
                                        />
                                        <div className="flex py-2 px-1 justify-between">
                                            <Checkbox
                                                classNames={{
                                                    label: "text-small",
                                                }}
                                            >
                                                Remember me
                                            </Checkbox>
                                            <Link color="primary" href="#" size="sm">
                                                Forgot password?
                                            </Link>
                                        </div>
                                    </ModalBody>
                                    <ModalFooter>
                                        <Button color="danger" variant="flat" onPress={onClose}>
                                            Close
                                        </Button>
                                        <Button color="primary" onPress={onClose}>
                                            Sign in
                                        </Button>
                                    </ModalFooter>
                                </>
                            )}
                        </ModalContent>
                    </Modal>

                </NavbarItem>
            </NavbarContent>
        </Navbar>
    )
};

export default NavBar;